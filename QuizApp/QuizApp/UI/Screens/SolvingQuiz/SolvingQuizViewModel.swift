import Combine
import SwiftUI

class SolvingQuizViewModel: ObservableObject {

    @Published var quiz: QuizStartResponse = .empty
    @Published var progressData: [ProgressData] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var progressText: String = ""
    @Published var errorMessage: String = ""

    var isFinished: Bool = false

    @Published var result: QuizResult = .empty

    private var id: Int!

    private var useCase: SolvingQuizUseCaseProtocol!

    private var correctQuestions: Int = 0
    private var didFinishQuiz: Bool = false

    init(id: Int, useCase: SolvingQuizUseCaseProtocol) {
        self.id = id
        self.useCase = useCase

        Task {
            await startQuiz()
        }
    }

    init() {}

    @MainActor
    func startQuiz() {
        Task {
            do {
                let quiz = try await useCase.startQuiz(with: QuizStartRequestModel(id: id))
                self.quiz = QuizStartResponse(quiz)

                let unansweredColor: Color = .white.opacity(0.3)
                for question in quiz.questions {
                    if question.id == quiz.questions.first?.id {
                        progressData.append(ProgressData(id: question.id, color: .white))
                    } else {
                        progressData.append(ProgressData(id: question.id, color: unansweredColor))
                    }
                }

                setProgressText()
            } catch {
                errorMessage = """
Couldn't start quiz.
Please try again.
"""
            }
        }
    }

    @MainActor
    func selectedAnswer(with id: Int) {
        if isQuestionAnswered(for: id) { return }

        let question = quiz.questions[currentQuestionIndex]

        changeAnswerColors(for: question, selectedAnswerId: id)

        let currentProgressData = progressData[currentQuestionIndex]
        let isAnswerCorrect = quiz.questions[currentQuestionIndex].correctAnswerId == id

        if isAnswerCorrect {
            progressData[currentQuestionIndex] = currentProgressData.color(.correctAnswer)
            correctQuestions += 1
        } else {
            progressData[currentQuestionIndex] = currentProgressData.color(.incorrectAnswer)
        }

        let questionChangeDelay = 400

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(questionChangeDelay)) { [weak self] in
            self?.changeQuestion(with: id)
        }
    }

    private func changeQuestion(with id: Int) {
        if currentQuestionIndex < progressData.count - 1 {
            progressData[currentQuestionIndex + 1] = progressData[currentQuestionIndex + 1].color(.white)

            currentQuestionIndex += 1
            setProgressText()
        } else {
            finishQuiz()
            didFinishQuiz = true
        }
    }

    private func isQuestionAnswered(for id: Int) -> Bool {
        guard !didFinishQuiz else { return true }

        for index in 0..<currentQuestionIndex {
            if quiz.questions[index].answers.contains(where: { $0.id == id }) {
                return true
            }
        }

        return false
    }

    private func setProgressText() {
        progressText = "\(currentQuestionIndex + 1)/\(quiz.questions.count)"
    }

    private func changeAnswerColors(for question: Question, selectedAnswerId: Int) {
        quiz = QuizStartResponse(quiz, id: question.id, selectedAnswerId: selectedAnswerId)
    }

    private func finishQuiz() {
        let delayInMillis = 400
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delayInMillis)) { [weak self] in
            guard let self = self else { return }

            self.result = QuizResult(
                sessionId: self.quiz.sessionId,
                correctQuestions: self.correctQuestions,
                totalQuestions: self.quiz.questions.count)

            self.isFinished = true
        }
    }

}

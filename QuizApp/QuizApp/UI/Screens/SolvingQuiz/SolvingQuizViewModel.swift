import Combine
import UIKit

class SolvingQuizViewModel {

    private let id: Int

    private let router: AppRouterProtocol
    private let useCase: SolvingQuizUseCaseProtocol

    @Published var quiz: QuizStartResponse = .empty
    @Published var progressColors: [UIColor] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var progressText: String = ""
    @Published var errorMessage: String = ""

    private var correctQuestions: Int = 0
    private var didFinishQuiz: Bool = false

    init(id: Int, router: AppRouterProtocol, useCase: SolvingQuizUseCaseProtocol) {
        self.id = id
        self.router = router
        self.useCase = useCase
    }

    @MainActor
    func startQuiz() {
        Task {
            do {
                let quiz = try await useCase.startQuiz(with: QuizStartRequestModel(id: id))
                self.quiz = QuizStartResponse(quiz)

                let unansweredColor: UIColor = .white.withAlphaComponent(0.3)
                progressColors = [UIColor](repeating: unansweredColor, count: quiz.questions.count)
                progressColors[0] = .white
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

        let isAnswerCorrect = quiz.questions[currentQuestionIndex].correctAnswerId == id
        if isAnswerCorrect {
            progressColors[currentQuestionIndex] = .correctAnswerColor
            correctQuestions += 1
        } else {
            progressColors[currentQuestionIndex] = .incorrectAnswerColor
        }

        if currentQuestionIndex < progressColors.count - 1 {
            progressColors[currentQuestionIndex + 1] = .white
            currentQuestionIndex += 1
            setProgressText()
        } else {
            finishQuiz()
            didFinishQuiz = true
        }
    }

    private func isQuestionAnswered(for id: Int) -> Bool {
        if didFinishQuiz { return true }

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

            let result = QuizResult(
                sessionId: self.quiz.sessionId,
                correctQuestions: self.correctQuestions,
                totalQuestions: self.quiz.questions.count)
            self.router.showResults(with: result)
        }
    }

    func goBack() {
        router.goBack()
    }

}

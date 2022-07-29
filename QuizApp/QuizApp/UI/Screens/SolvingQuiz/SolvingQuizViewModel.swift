import Combine
import UIKit

class SolvingQuizViewModel {

    private let id: Int

    private let router: AppRouterProtocol
    private let useCase: SolvingQuizUseCaseProtocol

    @Published var quiz: QuizStartResponse = .empty
    @Published var progressColors: [UIColor] = []
    @Published var currentQuestionIndex: Int = 0

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
            } catch {

            }
        }
    }

    @MainActor
    func selectedAnswer(with id: Int) {
        let question = quiz.questions[currentQuestionIndex]

        changeAnswerColors(for: question, selectedAnswerId: id)

        let isAnswerCorrect = quiz.questions[currentQuestionIndex].correctAnswerId == id
        if isAnswerCorrect {
            progressColors[currentQuestionIndex] = .correctAnswerColor
        } else {
            progressColors[currentQuestionIndex] = .incorrectAnswerColor
        }

        if currentQuestionIndex + 1 < progressColors.count {
            progressColors[currentQuestionIndex + 1] = .white
        }

        if currentQuestionIndex >= quiz.questions.count - 1 { return }
        currentQuestionIndex += 1
    }

    private func changeAnswerColors(for question: Question, selectedAnswerId: Int) {
        quiz = QuizStartResponse(quiz, id: question.id, selectedAnswerId: selectedAnswerId)
    }

    func goBack() {
        router.goBack()
    }

}

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
        guard let questionIndex = progressColors.firstIndex(of: .white) else { return }

        let question = quiz.questions[questionIndex]

        changeAnswerColors(for: question, selectedAnswerId: id)

        let isAnswerCorrect = quiz.questions[questionIndex].correctAnswerId == id
        if isAnswerCorrect {
            progressColors[questionIndex] = .correctAnswerColor
        } else {
            progressColors[questionIndex] = .incorrectAnswerColor
        }

        if questionIndex + 1 < progressColors.count {
            progressColors[questionIndex + 1] = .white
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

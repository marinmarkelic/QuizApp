import Combine
import UIKit

class SolvingQuizViewModel {

    private let id: Int

    private let router: AppRouterProtocol
    private let useCase: SolvingQuizUseCaseProtocol

    @Published var quiz: QuizStartResponse = .empty
    @Published var progressColors: [UIColor] = []

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

        let isCorrectAnswer = quiz.questions[questionIndex].correctAnswerId == id
        if isCorrectAnswer {
            progressColors[questionIndex] = .green
        } else {
            progressColors[questionIndex] = .red
        }

        if questionIndex + 1 < progressColors.count {
            progressColors[questionIndex + 1] = .white
        }
    }

    func goBack() {
        router.goBack()
    }

}

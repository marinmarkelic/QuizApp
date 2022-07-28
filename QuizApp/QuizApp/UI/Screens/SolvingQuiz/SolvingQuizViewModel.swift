import Combine
import UIKit

class SolvingQuizViewModel {

    private let router: AppRouterProtocol
    private let useCase: SolvingQuizUseCaseProtocol

    @Published var quiz: QuizStartResponse = .empty
    @Published var progressColors: [UIColor] = []

    init(id: Int, router: AppRouterProtocol, useCase: SolvingQuizUseCaseProtocol) {
        self.router = router
        self.useCase = useCase

        Task {
            await startQuiz(with: id)
        }
    }

    @MainActor
    func startQuiz(with id: Int) {
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

    func goBack() {
        router.goBack()
    }

}

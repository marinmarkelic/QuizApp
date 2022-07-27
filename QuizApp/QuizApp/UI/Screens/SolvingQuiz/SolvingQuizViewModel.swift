import Combine

class SolvingQuizViewModel {

    private let appRouter: AppRouterProtocol
    private let solvingQuizUseCase: SolvingQuizUseCase

    @Published var quiz: QuizStartResponse = .empty

    init(id: Int, appRouter: AppRouterProtocol, solvingQuizUseCase: SolvingQuizUseCase) {
        self.appRouter = appRouter
        self.solvingQuizUseCase = solvingQuizUseCase

        Task {
            await startQuiz(with: id)
        }
    }

    @MainActor
    func startQuiz(with id: Int) {
        Task {
            do {
                let quiz = try await solvingQuizUseCase.startQuiz(with: QuizStartRequestModel(id: id))
                self.quiz = QuizStartResponse(quiz)
            } catch {

            }
        }
    }

    func goBack() {
        appRouter.goBack()
    }

}

class SolvingQuizViewModel {

    private let appRouter: AppRouterProtocol
    private let solvingQuizUseCase: SolvingQuizUseCase

    init(appRouter: AppRouterProtocol, solvingQuizUseCase: SolvingQuizUseCase) {
        self.appRouter = appRouter
        self.solvingQuizUseCase = solvingQuizUseCase
    }

    @MainActor
    func startQuiz(with id: Int) {
        Task {
            do {
                try await print(solvingQuizUseCase.startQuiz(with: QuizStartRequestModel(id: id)))
                appRouter.showQuiz()
            } catch {

            }
        }
    }

}

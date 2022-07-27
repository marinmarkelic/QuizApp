class QuizDetailsViewModel {

    private var appRouter: AppRouterProtocol

    init(appRouter: AppRouterProtocol) {
        self.appRouter = appRouter
    }

    @MainActor
    func startQuiz(with id: Int) {
    }

}

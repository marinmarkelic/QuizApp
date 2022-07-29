class QuizResultViewModel {

    private let router: AppRouterProtocol

    init(router: AppRouterProtocol) {
        self.router = router
    }

    func exitQuiz() {
        router.showHome()
    }

}

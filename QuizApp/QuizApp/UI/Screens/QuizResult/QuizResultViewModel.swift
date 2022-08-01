class QuizResultViewModel {

    private let router: AppRouterProtocol
    private let useCase: SolvingQuizUseCase

    init(router: AppRouterProtocol, useCase: SolvingQuizUseCase) {
        self.router = router
        self.useCase = useCase

        endQuiz()
    }

    private func endQuiz() {
        Task {
            do {
                let request = QuizEndRequest(id: useCase.sessionID, numberOfCorrectQuestions: 2)
                let response = try await useCase.endQuiz(with: QuizEndRequestModel(request))
                print(response)
            } catch let err {
                print(err)
            }
        }
    }

    func exitQuiz() {
        router.showHome()
    }

}

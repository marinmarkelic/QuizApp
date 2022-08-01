import Combine

class QuizResultViewModel {

    private let result: Result

    private let router: AppRouterProtocol
    private let useCase: SolvingQuizUseCase

    @Published var text: String = ""

    init(result: Result, router: AppRouterProtocol, useCase: SolvingQuizUseCase) {
        self.result = result
        self.router = router
        self.useCase = useCase

        setText()
        endQuiz()
    }

    private func endQuiz() {
        Task {
            do {
                let request = QuizEndRequest(id: result.sessionId, numberOfCorrectQuestions: result.correctQuestions)
                let response = try await useCase.endQuiz(with: QuizEndRequestModel(request))
                print(response)
            } catch let err {
                print(err)
            }
        }
    }

    private func setText() {
        text = "\(result.correctQuestions)/\(result.totalQuestions)"
    }

    func exitQuiz() {
        router.showHome()
    }

}

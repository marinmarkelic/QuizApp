import Combine

class QuizResultViewModel {

    private let result: QuizResult

    private let router: AppRouterProtocol
    private let useCase: SolvingQuizUseCase

    @Published var text: String = ""

    init(result: QuizResult, router: AppRouterProtocol, useCase: SolvingQuizUseCase) {
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
                _ = try await useCase.endQuiz(with: QuizEndRequestModel(request))
            } catch _ {}
        }
    }

    private func setText() {
        text = "\(result.correctQuestions)/\(result.totalQuestions)"
    }

    func exitQuiz() {
        router.showHome()
    }

}

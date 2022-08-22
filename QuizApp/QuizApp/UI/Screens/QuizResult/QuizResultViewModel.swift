import Combine

class QuizResultViewModel: ObservableObject {

    @Published var text: String = ""

    private var result: QuizResult!

    private var router: AppRouterProtocol!
    private var useCase: SolvingQuizUseCase!

    init(result: QuizResult, router: AppRouterProtocol, useCase: SolvingQuizUseCase) {
        self.result = result
        self.router = router
        self.useCase = useCase

        setText()
    }

    init() {}

//    func endQuiz() {
//        Task {
//            do {
//                let request = QuizEndRequest(id: result.sessionId, numberOfCorrectQuestions: result.correctQuestions)
//                _ = try await useCase.endQuiz(with: QuizEndRequestModel(request))
//            } catch _ {}
//        }
//    }

    private func setText() {
        text = "\(result.correctQuestions)/\(result.totalQuestions)"
    }

    func exitQuiz() {
        router.showHome()
    }

}

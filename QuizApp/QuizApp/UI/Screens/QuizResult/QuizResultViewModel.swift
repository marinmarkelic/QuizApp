import Combine

class QuizResultViewModel {

    private let result: QuizResult

    private let router: AppRouterProtocol

    @Published var text: String = ""

    init(result: QuizResult, router: AppRouterProtocol) {
        self.result = result
        self.router = router

        setText()
    }

    private func setText() {
        text = "\(result.correctQuestions)/\(result.totalQuestions)"
    }

    func exitQuiz() {
        router.showHome()
    }

}

import Combine

class QuizResultViewModel {

    private let result: Result

    private let router: AppRouterProtocol

    @Published var text: String = ""

    init(result: Result, router: AppRouterProtocol) {
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

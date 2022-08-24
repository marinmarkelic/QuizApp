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

    private func setText() {
        text = "\(result.correctQuestions)/\(result.totalQuestions)"
    }

    func exitQuiz() {
        router.showHome()
    }

}

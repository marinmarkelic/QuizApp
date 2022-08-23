import Combine

class QuizResultViewModel: ObservableObject {

    @Published var text: String = ""

    private var result: QuizResult!

    private var useCase: SolvingQuizUseCase!

    init(result: QuizResult, useCase: SolvingQuizUseCase) {
        self.result = result
        self.useCase = useCase

        setText()
    }

    init() {}

    private func setText() {
        text = "\(result.correctQuestions)/\(result.totalQuestions)"
    }

}

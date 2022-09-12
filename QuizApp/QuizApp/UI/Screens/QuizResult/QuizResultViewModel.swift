import Combine

class QuizResultViewModel: ObservableObject {

    @Published var score: Double = 0
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
        score = Double(result.correctQuestions)
        text = "/\(result.totalQuestions)"
    }

    func exitQuiz() {
    }

}

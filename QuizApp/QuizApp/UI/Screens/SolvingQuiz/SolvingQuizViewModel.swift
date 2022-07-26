class SolvingQuizViewModel {

    private let solvingQuizUseCase: SolvingQuizUseCase

    init(solvingQuizUseCase: SolvingQuizUseCase) {
        self.solvingQuizUseCase = solvingQuizUseCase
    }

    func startQuiz() {
        Task {
            do {
                try await print(solvingQuizUseCase.startQuiz(with: QuizStartRequestModel(id: 1)))
            } catch {

            }
        }
    }

}

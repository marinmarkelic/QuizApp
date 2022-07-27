class SolvingQuizViewModel {

    private let solvingQuizUseCase: SolvingQuizUseCase

    init(solvingQuizUseCase: SolvingQuizUseCase, id: Int) {
        self.solvingQuizUseCase = solvingQuizUseCase

        Task {
            await startQuiz(with: id)
        }
    }

    @MainActor
    func startQuiz(with id: Int) {
        Task {
            do {
                try await print(solvingQuizUseCase.startQuiz(with: QuizStartRequestModel(id: id)))
            } catch {

            }
        }
    }

}

class SolvingQuizViewModel {

    private let solvingQuizUseCase: SolvingQuizUseCase

    init(solvingQuizUseCase: SolvingQuizUseCase) {
        self.solvingQuizUseCase = solvingQuizUseCase
    }

    func startQuiz(with id: Int) {
        Task {
            do {
                try await print(solvingQuizUseCase.startQuiz(with: QuizStartRequestModel(id: id)))
            } catch {

            }
        }
    }

}

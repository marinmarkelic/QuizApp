import Combine

class SolvingQuizViewModel {

    private let solvingQuizUseCase: SolvingQuizUseCase

    @Published var quiz: QuizStartResponse = .empty

    init(id: Int, solvingQuizUseCase: SolvingQuizUseCase) {
        self.solvingQuizUseCase = solvingQuizUseCase

        Task {
            await startQuiz(with: id)
        }
    }

    @MainActor
    func startQuiz(with id: Int) {
        Task {
            do {
                let quiz = try await solvingQuizUseCase.startQuiz(with: QuizStartRequestModel(id: id))
                self.quiz = QuizStartResponse(quiz)
            } catch {

            }
        }
    }

}

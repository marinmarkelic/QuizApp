import Combine

class SolvingQuizViewModel {

    private let solvingQuizUseCase: SolvingQuizUseCase

    @Published var quiz: QuizStartResponse = .empty

    init(solvingQuizUseCase: SolvingQuizUseCase) {
        self.solvingQuizUseCase = solvingQuizUseCase
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

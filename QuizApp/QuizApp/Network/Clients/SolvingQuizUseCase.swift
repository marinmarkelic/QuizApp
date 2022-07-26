protocol SolvingQuizUseCaseProtocol {

    func startQuiz(with request: QuizStartRequestModel) async throws
}

class SolvingQuizUseCase: SolvingQuizUseCaseProtocol {

    private let quizRepository: QuizRepository

    init(quizRepository: QuizRepository) {
        self.quizRepository = quizRepository
    }

    func startQuiz(with request: QuizStartRequestModel) async throws {

    }

}

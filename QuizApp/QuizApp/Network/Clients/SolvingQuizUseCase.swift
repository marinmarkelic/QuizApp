protocol SolvingQuizUseCaseProtocol {

    func startQuiz(with request: QuizStartRequestModel) async throws -> QuizStartResponseModel
}

class SolvingQuizUseCase: SolvingQuizUseCaseProtocol {

    private let quizRepository: QuizRepository

    init(quizRepository: QuizRepository) {
        self.quizRepository = quizRepository
    }

    func startQuiz(with request: QuizStartRequestModel) async throws -> QuizStartResponseModel {
        let response = try await quizRepository.startQuiz(with: QuizStartRequestRepoModel(request))
        return QuizStartResponseModel(response)
    }
}

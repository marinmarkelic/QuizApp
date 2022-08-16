protocol SolvingQuizUseCaseProtocol {

    func startQuiz(with request: QuizStartRequestModel) async throws -> QuizStartResponseModel

    func endQuiz(with request: QuizEndRequestModel) async throws -> QuizEndResponseModel

}

class SolvingQuizUseCase: SolvingQuizUseCaseProtocol {

    private let repository: QuizRepository

    init(repository: QuizRepository) {
        self.repository = repository
    }

    func startQuiz(with request: QuizStartRequestModel) async throws -> QuizStartResponseModel {
        let response = try await repository.startQuiz(with: QuizStartRequestRepoModel(request))
        return QuizStartResponseModel(response)
    }

    func endQuiz(with request: QuizEndRequestModel) async throws -> QuizEndResponseModel {
        let response = try await repository.endQuiz(with: QuizEndRequestRepoModel(request))
        return QuizEndResponseModel(response)
    }

}

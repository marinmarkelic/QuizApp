protocol SolvingQuizUseCaseProtocol {

    func startQuiz(with request: QuizStartRequestModel) async throws -> QuizStartResponseModel

    func endQuiz(with request: QuizEndRequestModel) async throws -> QuizEndResponseModel

}

class SolvingQuizUseCase: SolvingQuizUseCaseProtocol {

    var sessionID = "" // Remove

    private let quizRepository: QuizRepository

    init(quizRepository: QuizRepository) {
        self.quizRepository = quizRepository
    }

    func startQuiz(with request: QuizStartRequestModel) async throws -> QuizStartResponseModel {
        let response = try await quizRepository.startQuiz(with: QuizStartRequestRepoModel(request))
        sessionID = response.sessionId
        return QuizStartResponseModel(response)
    }

    func endQuiz(with request: QuizEndRequestModel) async throws -> QuizEndResponseModel {
        let response = try await quizRepository.endQuiz(with: QuizEndRequestRepoModel(request))
        return QuizEndResponseModel(response)
    }

}

protocol QuizNetworkClientProtocol {

    func fetchQuizzes(for category: CategoryNetworkDataModel) async throws -> [QuizNetworkDataModel]

    func fetchAllQuizzes() async throws -> [QuizNetworkDataModel]

    func startQuiz(with request: QuizStartRequestNetworkDataModel) async throws -> QuizStartResponseNetworkDataModel

    func endQuiz(
        with request: QuizEndRequestNetworkDataModel,
        id: String
    ) async throws -> QuizEndResponseNetworkDataModel

}

class QuizNetworkClient: QuizNetworkClientProtocol {

    private let networkClient: NetworkClient

    private let quizPath = "/v1/quiz/list"

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func fetchQuizzes(for category: CategoryNetworkDataModel) async throws -> [QuizNetworkDataModel] {
        try await networkClient.get(path: "\(quizPath)?category=\(category.rawValue)")
    }

    func fetchAllQuizzes() async throws -> [QuizNetworkDataModel] {
        try await networkClient.get(path: "\(quizPath)")
    }

    func startQuiz(with request: QuizStartRequestNetworkDataModel) async throws -> QuizStartResponseNetworkDataModel {
        try await networkClient.post(path: getStartQuizPath(id: request.id), body: request)
    }

    private func getStartQuizPath(id: Int) -> String {
        "/v1/quiz/\(id)/session/start"
    }

    func endQuiz(
        with request: QuizEndRequestNetworkDataModel,
        id: String
    ) async throws -> QuizEndResponseNetworkDataModel {
        try await networkClient.post(path: getEndQuizPath(id: id), body: request)
    }

    private func getEndQuizPath(id: String) -> String {
        "/v1/quiz/session/\(id)/end"
    }

}

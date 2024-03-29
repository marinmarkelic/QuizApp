protocol QuizNetworkClientProtocol {

    func fetchQuizzes(for category: CategoryNetworkDataModel) async throws -> [QuizNetworkDataModel]

    func fetchAllQuizzes() async throws -> [QuizNetworkDataModel]

    func fetchLeaderboard(for id: Int) async throws -> [LeaderboardPointsNetworkDataModel]

    func startQuiz(with request: QuizStartRequestNetworkDataModel) async throws -> QuizStartResponseNetworkDataModel

    func endQuiz(
        with request: QuizEndRequestNetworkDataModel,
        id: String
    ) async throws -> QuizEndResponseNetworkDataModel

}

class QuizNetworkClient: QuizNetworkClientProtocol {

    private let networkClient: NetworkClient

    private let quizPath = "/v1/quiz/list"
    private let leaderboardPath = "/v1/quiz/leaderboard"

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func fetchQuizzes(for category: CategoryNetworkDataModel) async throws -> [QuizNetworkDataModel] {
        try await networkClient.get(path: "\(quizPath)?category=\(category.rawValue)")
    }

    func fetchAllQuizzes() async throws -> [QuizNetworkDataModel] {
        try await networkClient.get(path: "\(quizPath)")
    }

    func fetchLeaderboard(for id: Int) async throws -> [LeaderboardPointsNetworkDataModel] {
        try await networkClient.get(path: "\(leaderboardPath)?quizId=\(id)")
    }

    func startQuiz(with request: QuizStartRequestNetworkDataModel) async throws -> QuizStartResponseNetworkDataModel {
        try await networkClient.post(path: "/v1/quiz/\(request.id)/session/start", body: request)
    }

    func endQuiz(
        with request: QuizEndRequestNetworkDataModel,
        id: String
    ) async throws -> QuizEndResponseNetworkDataModel {
        try await networkClient.post(path: "/v1/quiz/session/\(id)/end", body: request)
    }

}

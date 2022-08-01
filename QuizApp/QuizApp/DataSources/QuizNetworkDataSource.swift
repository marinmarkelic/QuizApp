protocol QuizNetworkDataSourceProtocol {

    func fetchQuizzes(for category: CategoryDataModel) async throws -> [QuizResponseDataModel]

    func fetchAllQuizzes() async throws -> [QuizResponseDataModel]

    func fetchLeaderboard(for id: Int) async throws -> LeaderboardDataModel

    func startQuiz(with request: QuizStartRequestDataModel) async throws -> QuizStartResponseDataModel

    func endQuiz(with request: QuizEndRequestDataModel) async throws -> QuizEndResponseDataModel

}

class QuizNetworkDataSource: QuizNetworkDataSourceProtocol {

    private let quizNetworkClient: QuizNetworkClientProtocol

    init(quizNetworkClient: QuizNetworkClientProtocol) {
        self.quizNetworkClient = quizNetworkClient
    }

    func fetchQuizzes(for category: CategoryDataModel) async throws -> [QuizResponseDataModel] {
        let quizzes = try await quizNetworkClient.fetchQuizzes(
            for: CategoryNetworkDataModel(rawValue: category.rawValue)!)
        return quizzes
            .map { QuizResponseDataModel($0) }
    }

    func fetchAllQuizzes() async throws -> [QuizResponseDataModel] {
        let quizzes = try await quizNetworkClient.fetchAllQuizzes()
        return quizzes
            .map { QuizResponseDataModel($0) }
    }

    func fetchLeaderboard(for id: Int) async throws -> LeaderboardDataModel {
        let response = try await quizNetworkClient.fetchLeaderboard(for: id)
        return LeaderboardDataModel(response)
    }

    func startQuiz(with request: QuizStartRequestDataModel) async throws -> QuizStartResponseDataModel {
        let response = try await quizNetworkClient.startQuiz(with: QuizStartRequestNetworkDataModel(request))
        return QuizStartResponseDataModel(response)
    }

    func endQuiz(with request: QuizEndRequestDataModel) async throws -> QuizEndResponseDataModel {
        let response = try await quizNetworkClient.endQuiz(
            with: QuizEndRequestNetworkDataModel(request),
            id: request.id)
        return QuizEndResponseDataModel(response)
    }

}

protocol QuizNetworkClientProtocol {

    func fetchQuizzes(for category: CategoryNetworkDataModel) async throws -> [QuizNetworkDataModel]

}

class QuizNetworkClient: QuizNetworkClientProtocol {

    private let networkClient: NetworkClient

    private let quizPath = "/v1/quiz/list?category="

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func fetchQuizzes(for category: CategoryNetworkDataModel) async throws -> [QuizNetworkDataModel] {
        try await networkClient.get(path: "\(quizPath)\(category.rawValue)")
    }

}

protocol QuizNetworkClientProtocol {

    func fetchQuizesFor(category: String) async throws -> [QuizNetworkDataModel]

}

class QuizNetworkClient: QuizNetworkClientProtocol {

    private let networkClient: NetworkClient

    private let quizPath = "/v1/quiz/list?category="

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func fetchQuizesFor(category: String) async throws -> [QuizNetworkDataModel] {
        try await networkClient.get(path: "\(quizPath)\(category)")
    }

}

struct QuizNetworkDataModel: Decodable {

    let id: Int
    let name: String
    let description: String
    let category: String
    let difficulty: String
    let imageUrl: String
    let numberOfQuestions: Int

}

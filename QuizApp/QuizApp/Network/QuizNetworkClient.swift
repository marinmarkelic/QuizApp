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

struct QuizNetworkDataModel: Decodable {

    let id: Int
    let name: String
    let description: String
    let category: CategoryNetworkDataModel
    let difficulty: DifficultyNetworkDataModel
    let imageUrl: String
    let numberOfQuestions: Int

}

enum CategoryNetworkDataModel: String, Decodable {

    case sport = "SPORT"
    case movies = "MOVIES"
    case music = "MUSIC"
    case geography = "GEOGRAPHY"

}

enum DifficultyNetworkDataModel: String, Decodable {

    case easy = "EASY"
    case normal = "NORMAL"
    case hard = "HARD"

}

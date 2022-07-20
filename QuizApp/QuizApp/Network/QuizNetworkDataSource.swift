protocol QuizNetworkDataSourceProtocol {

    func fetchQuizzes(for category: CategoryDataModel) async throws -> [QuizResponseDataModel]

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

}

struct QuizResponseDataModel {

    let id: Int
    let name: String
    let description: String
    let category: CategoryDataModel
    let difficulty: DifficultyDataModel
    let imageUrl: String
    let numberOfQuestions: Int

}

extension QuizResponseDataModel {

    init(_ quiz: QuizNetworkDataModel) {
        id = quiz.id
        name = quiz.name
        description = quiz.description
        category = CategoryDataModel(rawValue: quiz.category.rawValue)!
        difficulty = DifficultyDataModel(rawValue: quiz.difficulty.rawValue)!
        imageUrl = quiz.imageUrl
        numberOfQuestions = quiz.numberOfQuestions
    }

}

enum CategoryDataModel: String {

    case sport = "SPORT"
    case movies = "MOVIES"
    case music = "MUSIC"
    case geography = "GEOGRAPHY"

}

enum DifficultyDataModel: String {

    case easy = "EASY"
    case normal = "NORMAL"
    case hard = "HARD"

}

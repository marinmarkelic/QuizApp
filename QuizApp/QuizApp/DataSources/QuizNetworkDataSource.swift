protocol QuizNetworkDataSourceProtocol {

    func fetchQuizzes(for category: CategoryDataModel) async throws -> [QuizResponseDataModel]

    func fetchAllQuizzes() async throws -> [QuizResponseDataModel]

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

}

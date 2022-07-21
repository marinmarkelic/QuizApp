protocol QuizRepositoryProtocol {

    func fetchQuizzes(for category: CategoryRepoModel) async throws -> [QuizRepoModel]

}

class QuizRepository: QuizRepositoryProtocol {

    private let quizNetworkDataSource: QuizNetworkDataSourceProtocol

    init(quizNetworkDataSource: QuizNetworkDataSourceProtocol) {
        self.quizNetworkDataSource = quizNetworkDataSource
    }

    func fetchQuizzes(for category: CategoryRepoModel) async throws -> [QuizRepoModel] {
        let quizzes = try await quizNetworkDataSource.fetchQuizzes(
            for: CategoryDataModel(rawValue: category.rawValue)!)
        return quizzes
            .map { QuizRepoModel($0) }
    }

}
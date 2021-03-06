protocol QuizRepositoryProtocol {

    func fetchQuizzes(for category: CategoryRepoModel) async throws -> [QuizRepoModel]

    func fetchAllQuizzes() async throws -> [QuizRepoModel]

    func startQuiz(with request: QuizStartRequestRepoModel) async throws -> QuizStartResponseRepoModel

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

    func fetchAllQuizzes() async throws -> [QuizRepoModel] {
        let quizzes = try await quizNetworkDataSource.fetchAllQuizzes()
        return quizzes
            .map { QuizRepoModel($0) }
    }

    func startQuiz(with request: QuizStartRequestRepoModel) async throws -> QuizStartResponseRepoModel {
        let response = try await quizNetworkDataSource.startQuiz(with: QuizStartRequestDataModel(request))
        return QuizStartResponseRepoModel(response)
    }

}

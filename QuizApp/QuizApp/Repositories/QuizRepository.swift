protocol QuizRepositoryProtocol {

    func fetchQuizzes(for category: CategoryRepoModel) async throws -> [QuizRepoModel]

    func fetchAllQuizzes() async throws -> [QuizRepoModel]

    func fetchLeaderboard(for id: Int) async throws -> LeaderboardRepoModel

    func startQuiz(with request: QuizStartRequestRepoModel) async throws -> QuizStartResponseRepoModel

    func endQuiz(with request: QuizEndRequestRepoModel) async throws -> QuizEndResponseRepoModel

}

class QuizRepository: QuizRepositoryProtocol {

    private let quizNetworkDataSource: QuizNetworkDataSourceProtocol
    private let quizDatabaseDataSource: QuizDatabaseDataSourceProtocol

    init(quizNetworkDataSource: QuizNetworkDataSourceProtocol, quizDatabaseDataSource: QuizDatabaseDataSourceProtocol) {
        self.quizNetworkDataSource = quizNetworkDataSource
        self.quizDatabaseDataSource = quizDatabaseDataSource
    }

    func fetchQuizzes(for category: CategoryRepoModel) async throws -> [QuizRepoModel] {
        do {
            let quizzes = try await quizNetworkDataSource
                .fetchQuizzes(for: CategoryDataModel(rawValue: category.rawValue)!)
                .map { QuizRepoModel($0) }
            quizDatabaseDataSource.save(quizzes: quizzes.map { QuizDatabaseModel($0) })

            return quizzes
        } catch RequestError.disconnectedError {
            let quizzes = quizDatabaseDataSource
                .fetchQuizzes(for: category.rawValue)
                .map { QuizRepoModel($0) }

            return quizzes
        } catch let err {
            throw err
        }
    }

    func fetchAllQuizzes() async throws -> [QuizRepoModel] {
        do {
            let quizzes = try await quizNetworkDataSource.fetchAllQuizzes().map { QuizRepoModel($0) }
            quizDatabaseDataSource.save(quizzes: quizzes.map { QuizDatabaseModel($0) })
            return quizzes
        } catch RequestError.disconnectedError {
            let quizzes = quizDatabaseDataSource.fetchQuizzes().map { QuizRepoModel($0) }
            return quizzes
        } catch let err {
            throw err
        }
    }

    func fetchLeaderboard(for id: Int) async throws -> LeaderboardRepoModel {
        let response = try await quizNetworkDataSource.fetchLeaderboard(for: id)
        return LeaderboardRepoModel(response)
    }

    func startQuiz(with request: QuizStartRequestRepoModel) async throws -> QuizStartResponseRepoModel {
        let response = try await quizNetworkDataSource.startQuiz(with: QuizStartRequestDataModel(request))
        return QuizStartResponseRepoModel(response)
    }

    func endQuiz(with request: QuizEndRequestRepoModel) async throws -> QuizEndResponseRepoModel {
        let response = try await quizNetworkDataSource.endQuiz(with: QuizEndRequestDataModel(request))
        return QuizEndResponseRepoModel(response)
    }

}

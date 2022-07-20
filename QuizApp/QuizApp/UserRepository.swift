protocol UserRepositoryProtocol {

    var userInfo: UserInfoRepoModel { get async throws }

    func logIn(username: String, password: String) async throws -> LoginResponseRepoModel

    func logOut()

    func fetchQuizzesFor(category: String) async throws -> [QuizRepoModel]

}

class UserRepository: UserRepositoryProtocol {

    private let userNetworkDataSource: UserNetworkDataSourceProtocol
    private let userDatabaseDataSource: UserDatabaseDataSourceProtocol

    var userInfo: UserInfoRepoModel {
        get async throws {
            UserInfoRepoModel(try await userNetworkDataSource.userInfo)
        }
    }

    init(userNetworkDataSource: UserNetworkDataSourceProtocol, userDatabaseDataSource: UserDatabaseDataSourceProtocol) {
        self.userNetworkDataSource = userNetworkDataSource
        self.userDatabaseDataSource = userDatabaseDataSource
    }

    func logIn(username: String, password: String) async throws -> LoginResponseRepoModel {
        let responseRepoModel = LoginResponseRepoModel(
            try await userNetworkDataSource.logIn(username: username, password: password))
        save(accessToken: responseRepoModel.accessToken)

        return responseRepoModel
    }

    func logOut() {
        userDatabaseDataSource.deleteAccessToken()
        userDatabaseDataSource.deleteUserInfo()
    }

    private func save(accessToken: String) {
        userDatabaseDataSource.save(accessToken: accessToken)
    }

    func save(userInfo: UserInfoRepoModel) async throws -> UserInfoRepoModel {
        try await UserInfoRepoModel(userNetworkDataSource.save(name: userInfo.name))
    }

    func fetchQuizzesFor(category: String) async throws -> [QuizRepoModel] {
        let quizzes = try await userNetworkDataSource.fetchQuizzesFor(category: category)
        var responseQuizzes: [QuizRepoModel] = []

        for quiz in quizzes {
            responseQuizzes.append(QuizRepoModel(quiz))
        }

        return responseQuizzes
    }

}

struct LoginResponseRepoModel {

    var accessToken: String

}

extension LoginResponseRepoModel {

    init(_ responseDataModel: LoginResponseDataModel) {
        accessToken = responseDataModel.accessToken
    }

}

struct UserInfoRepoModel {

    let username: String
    let name: String

}

extension UserInfoRepoModel {

    init(_ userInfo: UserInfoDataModel) {
        username = userInfo.email
        name = userInfo.name
    }

}

struct QuizRepoModel {

    let id: Int
    let name: String
    let description: String
    let category: String
    let difficulty: String
    let imageUrl: String
    let numberOfQuestions: Int

}

extension QuizRepoModel {

    init(_ quiz: QuizResponseDataModel) {
        id = quiz.id
        name = quiz.name
        description = quiz.description
        category = quiz.category
        difficulty = quiz.difficulty
        imageUrl = quiz.imageUrl
        numberOfQuestions = quiz.numberOfQuestions
    }

}

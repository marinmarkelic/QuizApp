protocol UserNetworkDataSourceProtocol {

    var userInfo: UserInfoDataModel { get async throws }

    func logIn(username: String, password: String) async throws -> LoginResponseDataModel

    func check() async throws

    func save(name: String) async throws -> UserInfoDataModel

    func fetchQuizzes(for category: CategoryDataModel) async throws -> [QuizResponseDataModel]

}

class UserNetworkDataSource: UserNetworkDataSourceProtocol {

    private let loginClient: LoginNetworkClientProtocol
    private let checkNetworkClient: CheckNetworkClientProtocol
    private let userNetworkClient: UserNetworkClientProtocol
    private let quizNetworkClient: QuizNetworkClientProtocol

    var userInfo: UserInfoDataModel {
        get async throws {
            try await UserInfoDataModel(userNetworkClient.userInfo)
        }
    }

    init(
        loginClient: LoginNetworkClientProtocol,
        checkNetworkClient: CheckNetworkClientProtocol,
        userNetworkClient: UserNetworkClientProtocol,
        quizNetworkClient: QuizNetworkClientProtocol
    ) {
        self.loginClient = loginClient
        self.checkNetworkClient = checkNetworkClient
        self.userNetworkClient = userNetworkClient
        self.quizNetworkClient = quizNetworkClient
    }

    func logIn(username: String, password: String) async throws -> LoginResponseDataModel {
        LoginResponseDataModel(try await loginClient.logIn(username: username, password: password))
    }

    func check() async throws {
        try await checkNetworkClient.check()
    }

    func save(name: String) async throws -> UserInfoDataModel {
        try await UserInfoDataModel(userNetworkClient.save(name: name))
    }

    func fetchQuizzes(for category: CategoryDataModel) async throws -> [QuizResponseDataModel] {
        let quizzes = try await quizNetworkClient.fetchQuizzes(
            for: CategoryNetworkDataModel(rawValue: category.rawValue)!)
        var responseQuizzes: [QuizResponseDataModel] = []

        for quiz in quizzes {
            responseQuizzes.append(QuizResponseDataModel(quiz))
        }

        return responseQuizzes
    }

}

struct LoginResponseDataModel {

    let accessToken: String

}

extension LoginResponseDataModel {

    init(_ loginResponse: LoginResponse) {
        accessToken = loginResponse.accessToken
    }

}

struct UserInfoDataModel {

    let id: Int
    let email: String
    let name: String

}

extension UserInfoDataModel {

    init(_ userData: UserInfoNetworkDataModel) {
        email = userData.email
        id = userData.id
        name = userData.name
    }

}

struct QuizResponseDataModel {

    let id: Int
    let name: String
    let description: String
    let category: CategoryDataModel
    let difficulty: String
    let imageUrl: String
    let numberOfQuestions: Int

}

extension QuizResponseDataModel {

    init(_ quiz: QuizNetworkDataModel) {
        id = quiz.id
        name = quiz.name
        description = quiz.description
        category = CategoryDataModel(rawValue: quiz.category.rawValue)!
        difficulty = quiz.difficulty
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

protocol UserNetworkDataSourceProtocol {

    var userInfo: UserInfoDataModel { get async throws }

    func logIn(username: String, password: String) async throws -> LoginResponseDataModel

    func check() async throws

    func save(name: String) async throws -> UserInfoDataModel

}

class UserNetworkDataSource: UserNetworkDataSourceProtocol {

    private let loginClient: LoginNetworkClientProtocol
    private let checkNetworkClient: CheckNetworkClientProtocol
    private let userNetworkClient: UserNetworkClientProtocol

    var userInfo: UserInfoDataModel {
        get async throws {
            try await UserInfoDataModel(userNetworkClient.userInfo)
        }
    }

    init(
        loginClient: LoginNetworkClientProtocol,
        checkNetworkClient: CheckNetworkClientProtocol,
        userNetworkClient: UserNetworkClientProtocol
    ) {
        self.loginClient = loginClient
        self.checkNetworkClient = checkNetworkClient
        self.userNetworkClient = userNetworkClient
    }

    func logIn(username: String, password: String) async throws -> LoginResponseDataModel {
        LoginResponseDataModel(try await loginClient.logIn(username: username, password: password))
    }

    func check() async throws {
        try await checkNetworkClient.check()
    }

    func save(name: String) async throws -> UserInfoDataModel {
        return try await UserInfoDataModel(userNetworkClient.save(name: name))
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

    let email: String
    let id: Int
    let name: String

}

extension UserInfoDataModel {

    init(_ userData: UserInfoNetworkDataModel) {
        email = userData.email
        id = userData.id
        name = userData.name
    }

}

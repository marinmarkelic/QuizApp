protocol UserNetworkDataSourceProtocol {

    var userInfo: UserInfoDataModel { get async throws }

    func logIn(username: String, password: String) async throws -> LoginResponseDataModel

    func check() async throws

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

    let name: String

}

extension UserInfoDataModel {

    init(_ userData: UserInfoNetworkDataModel) {
        name = userData.name
    }

}

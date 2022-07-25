protocol UserNetworkDataSourceProtocol {

    var userInfo: UserInfoDataModel { get async throws }

    func logIn(username: String, password: String) async throws -> LoginResponseDataModel

    func check() async throws

    func save(name: String) async throws -> UserInfoDataModel

}

class UserNetworkDataSource: UserNetworkDataSourceProtocol {

    private let loginNetworkClient: LoginNetworkClientProtocol
    private let checkNetworkClient: CheckNetworkClientProtocol
    private let userNetworkClient: UserNetworkClientProtocol

    var userInfo: UserInfoDataModel {
        get async throws {
            try await UserInfoDataModel(userNetworkClient.userInfo)
        }
    }

    init(
        loginNetworkClient: LoginNetworkClientProtocol,
        checkNetworkClient: CheckNetworkClientProtocol,
        userNetworkClient: UserNetworkClientProtocol
    ) {
        self.loginNetworkClient = loginNetworkClient
        self.checkNetworkClient = checkNetworkClient
        self.userNetworkClient = userNetworkClient
    }

    func logIn(username: String, password: String) async throws -> LoginResponseDataModel {
        LoginResponseDataModel(try await loginNetworkClient.logIn(username: username, password: password))
    }

    func check() async throws {
        try await checkNetworkClient.check()
    }

    func save(name: String) async throws -> UserInfoDataModel {
        try await UserInfoDataModel(userNetworkClient.save(name: name))
    }

}

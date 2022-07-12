protocol UserNetworkDataSourceProtocol {

    func logIn(username: String, password: String) async throws -> LoginResponseDataModel

    func check() async throws

}

class UserNetworkDataSource: UserNetworkDataSourceProtocol {

    private let loginClient: LoginNetworkClientProtocol
    private let checkNetworkClient: CheckNetworkClientProtocol

    init(loginClient: LoginNetworkClientProtocol, checkNetworkClient: CheckNetworkClientProtocol) {
        self.loginClient = loginClient
        self.checkNetworkClient = checkNetworkClient
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

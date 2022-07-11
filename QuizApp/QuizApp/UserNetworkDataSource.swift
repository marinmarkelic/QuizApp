class UserNetworkDataSource: UserNetworkDataSourceProtocol {

    private var loginClient: LoginClientProtocol

    private var loginResponseData: LoginResponseData!

    init(loginClient: LoginClientProtocol) {
        self.loginClient = loginClient
    }

    func logIn(username: String, password: String) async throws -> LoginResponseData {
        return LoginResponseData(try await loginClient.logIn(username: username, password: password))
    }

}

struct LoginResponseData {

    let accessToken: String

    init(_ loginResponse: LoginResponse) {
        accessToken = loginResponse.accessToken
    }

}

protocol UserNetworkDataSourceProtocol {

    func logIn(username: String, password: String) async throws -> LoginResponseData

}

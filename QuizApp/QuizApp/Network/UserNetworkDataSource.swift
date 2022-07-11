protocol UserNetworkDataSourceProtocol {

    func logIn(username: String, password: String) async throws -> LoginResponseDataModel

}

class UserNetworkDataSource: UserNetworkDataSourceProtocol {

    private let loginClient: LoginClientProtocol

    init(loginClient: LoginClientProtocol) {
        self.loginClient = loginClient
    }

    func logIn(username: String, password: String) async throws -> LoginResponseDataModel {
        LoginResponseDataModel(try await loginClient.logIn(username: username, password: password))
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

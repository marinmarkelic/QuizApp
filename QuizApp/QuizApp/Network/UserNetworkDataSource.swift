protocol UserNetworkDataSourceProtocol {

    func logIn(username: String, password: String) async throws -> LoginResponseDataModel

    func check()

}

class UserNetworkDataSource: UserNetworkDataSourceProtocol {

    private let loginClient: LoginClientProtocol
    private let checkNetworkClient: CheckNetworkClientProtocol

    init(loginClient: LoginClientProtocol, checkNetworkClient: CheckNetworkClientProtocol) {
        self.loginClient = loginClient
        self.checkNetworkClient = checkNetworkClient
    }

    func logIn(username: String, password: String) async throws -> LoginResponseDataModel {
        LoginResponseDataModel(try await loginClient.logIn(username: username, password: password))
    }

    func check() {
        Task {
            do {
                try await checkNetworkClient.check()
            } catch let error {
                print(error)
            }
        }
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

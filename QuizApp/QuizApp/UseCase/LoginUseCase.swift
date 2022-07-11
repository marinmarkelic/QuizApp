protocol LoginUseCaseProtocol {

    func logIn(username: String, password: String) async throws -> LoginResponseUseCase

}

class LoginUseCase: LoginUseCaseProtocol {

    private let userNetworkDataSource: UserNetworkDataSourceProtocol

    init(userNetworkDataSource: UserNetworkDataSourceProtocol) {
        self.userNetworkDataSource = userNetworkDataSource
    }

    func logIn(username: String, password: String) async throws -> LoginResponseUseCase {
        LoginResponseUseCase(try await userNetworkDataSource.logIn(username: username, password: password))
    }

}

struct LoginResponseUseCase {

    let accessToken: String

}

extension LoginResponseUseCase {

    init(_ loginResponse: LoginResponseDataModel) {
        accessToken = loginResponse.accessToken
    }

}

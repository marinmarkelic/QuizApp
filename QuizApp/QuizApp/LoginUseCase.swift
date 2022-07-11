class LoginUseCase: LoginUseCaseProtocol {

    private var userNetworkDataSource: UserNetworkDataSourceProtocol

    init(userNetworkDataSource: UserNetworkDataSourceProtocol) {
        self.userNetworkDataSource = userNetworkDataSource
    }

    func logIn(username: String, password: String) async throws -> LoginResponseUseCase {
        return LoginResponseUseCase(try await userNetworkDataSource.logIn(username: username, password: password))
    }

}

struct LoginResponseUseCase {

    let accessToken: String

    init(_ loginResponse: LoginResponseData) {
        accessToken = loginResponse.accessToken
    }
}

protocol LoginUseCaseProtocol {

    func logIn(username: String, password: String) async throws -> LoginResponseUseCase

}

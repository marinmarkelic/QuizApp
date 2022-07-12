protocol LoginUseCaseProtocol {

    func logIn(username: String, password: String) async throws -> LoginResponseUseCase

}

class LoginUseCase: LoginUseCaseProtocol {

    private let userRepository: UserRepositoryProtocol

    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    func logIn(username: String, password: String) async throws -> LoginResponseUseCase {
        LoginResponseUseCase(try await userRepository.logIn(username: username, password: password))
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

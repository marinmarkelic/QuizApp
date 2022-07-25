protocol LoginUseCaseProtocol {

    func logIn(username: String, password: String) async throws -> LoginResponseModel

}

class LoginUseCase: LoginUseCaseProtocol {

    private let userRepository: UserRepositoryProtocol

    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository

        print("loginuc init")
    }

    func logIn(username: String, password: String) async throws -> LoginResponseModel {
        LoginResponseModel(try await userRepository.logIn(username: username, password: password))
    }

}

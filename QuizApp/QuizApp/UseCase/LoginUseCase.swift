protocol LoginUseCaseProtocol {

    func logIn(username: String, password: String) async throws -> LoginResponseModel

}

class LoginUseCase: LoginUseCaseProtocol {

    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func logIn(username: String, password: String) async throws -> LoginResponseModel {
        LoginResponseModel(try await repository.logIn(username: username, password: password))
    }

}

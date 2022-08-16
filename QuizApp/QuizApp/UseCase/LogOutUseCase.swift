protocol LogOutUseCaseProtocol {

    func logOut()

}

class LogOutUseCase: LogOutUseCaseProtocol {

    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func logOut() {
        repository.logOut()
    }

}

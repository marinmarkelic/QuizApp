protocol LogOutUseCaseProtocol {

    func logOut()

}

class LogOutUseCase: LogOutUseCaseProtocol {

    private let userRepository: UserRepositoryProtocol

    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    func logOut() {
        userRepository.logOut()
    }

}

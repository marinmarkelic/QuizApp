protocol LogOutUseCaseProtocol {

    func logOut()
}

class LogOutUseCase: LogOutUseCaseProtocol {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func logOut() {
        userRepository.logOut()
    }}

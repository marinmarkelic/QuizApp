protocol UserUseCaseProtocol {

    func save(userInfo: UserInfo)

    func logOut()

    var userInfo: UserInfoModel { get }

}

class UserUseCase: UserUseCaseProtocol {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func save(userInfo: UserInfo) {
        userRepository.save(userInfo: UserInfoModel(userInfo))
    }

    func logOut() {
        userRepository.logOut()
    }

    var userInfo: UserInfoModel {
        UserInfoModel(userRepository.userInfo)
    }

}

struct UserInfoModel {

    let username: String

}

extension UserInfoModel {

    init(_ userInfo: UserInfo) {
        username = userInfo.username
    }

    init(_ userInfo: UserInfoRepoModel) {
        username = userInfo.username
    }

}

protocol UserUseCaseProtocol {

    func save(userInfo: UserInfo)

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

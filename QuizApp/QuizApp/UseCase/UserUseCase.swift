protocol UserUseCaseProtocol {

    func save(userInfo: UserInfoModel)

    var userInfo: UserInfoModel { get }

}

class UserUseCase: UserUseCaseProtocol {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func save(userInfo: UserInfoModel) {
        userRepository.save(userInfo: UserInfoRepoModel(userInfo))
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

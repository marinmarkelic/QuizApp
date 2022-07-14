protocol UserUseCaseProtocol {

    var userInfo: UserInfoModel { get }

    func save(userInfo: UserInfoModel)

}

class UserUseCase: UserUseCaseProtocol {

    private let userRepository: UserRepository

    var userInfo: UserInfoModel {
        UserInfoModel(userRepository.userInfo)
    }

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func save(userInfo: UserInfoModel) {
        userRepository.save(userInfo: UserInfoRepoModel(userInfo))
    }

}

struct UserInfoModel {

    let username: String
    let name: String

}

extension UserInfoModel {

    init(_ userInfo: UserInfoRepoModel) {
        username = userInfo.username
        name = userInfo.name
    }

}

extension UserInfoRepoModel {

    init(_ userInfo: UserInfoModel) {
        username = userInfo.username
        name = userInfo.name
    }

}

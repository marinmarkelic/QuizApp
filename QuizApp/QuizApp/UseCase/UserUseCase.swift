protocol UserUseCaseProtocol {

    var userInfo: UserInfoModel { get async throws }

    func save(userInfo: UserInfoModel) async throws -> UserInfoModel

}

class UserUseCase: UserUseCaseProtocol {

    private let userRepository: UserRepositoryProtocol

    var userInfo: UserInfoModel {
        get async throws {
            try await UserInfoModel(userRepository.userInfo)
        }
    }

    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    func save(userInfo: UserInfoModel) async throws -> UserInfoModel {
        try await UserInfoModel(userRepository.save(userInfo: UserInfoRepoModel(userInfo)))
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

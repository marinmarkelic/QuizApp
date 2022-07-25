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

        print("useruc init")
    }

    func save(userInfo: UserInfoModel) async throws -> UserInfoModel {
        try await UserInfoModel(userRepository.save(userInfo: UserInfoRepoModel(userInfo)))
    }

}

protocol UserUseCaseProtocol {

    var userInfo: UserInfoModel { get async throws }

    func save(userInfo: UserInfoModel) async throws -> UserInfoModel

}

class UserUseCase: UserUseCaseProtocol {

    private let repository: UserRepositoryProtocol

    var userInfo: UserInfoModel {
        get async throws {
            try await UserInfoModel(repository.userInfo)
        }
    }

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func save(userInfo: UserInfoModel) async throws -> UserInfoModel {
        try await UserInfoModel(repository.save(userInfo: UserInfoRepoModel(userInfo)))
    }

}

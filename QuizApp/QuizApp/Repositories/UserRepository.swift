protocol UserRepositoryProtocol {

    var userInfo: UserInfoRepoModel { get async throws }

    func save(userInfo: UserInfoRepoModel) async throws -> UserInfoRepoModel

    func logIn(username: String, password: String) async throws -> LoginResponseRepoModel

    func logOut()

}

class UserRepository: UserRepositoryProtocol {

    private let userNetworkDataSource: UserNetworkDataSourceProtocol
    private let userDatabaseDataSource: UserDatabaseDataSourceProtocol

    var userInfo: UserInfoRepoModel {
        get async throws {
            UserInfoRepoModel(try await userNetworkDataSource.userInfo)
        }
    }

    init(userNetworkDataSource: UserNetworkDataSourceProtocol, userDatabaseDataSource: UserDatabaseDataSourceProtocol) {
        self.userNetworkDataSource = userNetworkDataSource
        self.userDatabaseDataSource = userDatabaseDataSource
    }

    func logIn(username: String, password: String) async throws -> LoginResponseRepoModel {
        let responseRepoModel = LoginResponseRepoModel(
            try await userNetworkDataSource.logIn(username: username, password: password))
        save(accessToken: responseRepoModel.accessToken)

        return responseRepoModel
    }

    func logOut() {
        userDatabaseDataSource.deleteAccessToken()
        userDatabaseDataSource.deleteUserInfo()
    }

    private func save(accessToken: String) {
        userDatabaseDataSource.save(accessToken: accessToken)
    }

    func save(userInfo: UserInfoRepoModel) async throws -> UserInfoRepoModel {
        try await UserInfoRepoModel(userNetworkDataSource.save(name: userInfo.name))
    }

}

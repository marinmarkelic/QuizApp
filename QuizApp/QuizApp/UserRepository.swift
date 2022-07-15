protocol UserRepositoryProtocol {

    var userInfo: UserInfoRepoModel { get async throws }

    func logIn(username: String, password: String) async throws -> LoginResponseRepoModel

    func logOut()

}

class UserRepository: UserRepositoryProtocol {

    private let userNetworkDataSource: UserNetworkDataSourceProtocol
    private let userDatabaseDataSource: UserDatabaseDataSourceProtocol

    var userInfo: UserInfoRepoModel {
        get async throws {
            UserInfoRepoModel(
                username: userDatabaseDataSource.userInfo.username,
                name: try await userNetworkDataSource.userInfo.name)
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

    func save(userInfo: UserInfoRepoModel) async throws {
        userDatabaseDataSource.save(userInfo: UserInfoDataSourceModel(userInfo))
        _ = try await userNetworkDataSource.save(name: userInfo.name)
    }

}

struct LoginResponseRepoModel {

    var accessToken: String

}

extension LoginResponseRepoModel {

    init(_ responseDataModel: LoginResponseDataModel) {
        accessToken = responseDataModel.accessToken
    }

}

struct UserInfoRepoModel {

    let username: String
    let name: String

}

extension UserInfoRepoModel {

    init(_ userInfo: UserInfoDataSourceModel) {
        username = userInfo.username
        name = userInfo.name
    }

}

extension UserInfoDataSourceModel {

    init(_ userInfo: UserInfoRepoModel) {
        username = userInfo.username
        name = userInfo.name
    }

}

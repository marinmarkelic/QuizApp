protocol UserRepositoryProtocol {

    func logIn(username: String, password: String) async throws -> LoginResponseDataModel

}

class UserRepository: UserRepositoryProtocol {

    private let userNetworkDataSource: UserNetworkDataSourceProtocol
    private let userDatabaseDataSource: UserDatabaseDataSourceProtocol

    init(userNetworkDataSource: UserNetworkDataSourceProtocol, userDatabaseDataSource: UserDatabaseDataSourceProtocol) {
        self.userNetworkDataSource = userNetworkDataSource
        self.userDatabaseDataSource = userDatabaseDataSource
    }

    func logIn(username: String, password: String) async throws -> LoginResponseDataModel {
        let responseDataModel = try await userNetworkDataSource.logIn(username: username, password: password)
        storeAccessToken(accessToken: responseDataModel.accessToken)

        return responseDataModel
    }

    private func storeAccessToken(accessToken: String) {
        userDatabaseDataSource.storeAccessToken(accessToken: accessToken)
    }

}

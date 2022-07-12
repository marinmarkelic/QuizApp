protocol UserDatabaseDataSourceProtocol {

    func save(accessToken: String)
    func fetchAccessToken() -> String?

}

class UserDatabaseDataSource: UserDatabaseDataSourceProtocol {

    private let secureStorage = SecureStorage()

    func save(accessToken: String) {
        secureStorage.save(accessToken: accessToken)
    }

    func fetchAccessToken() -> String? {
        secureStorage.fetchAccessToken()
    }

}

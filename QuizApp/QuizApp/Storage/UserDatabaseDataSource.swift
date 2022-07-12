protocol UserDatabaseDataSourceProtocol {

    func save(accessToken: String)

    var accessToken: String? { get }

}

class UserDatabaseDataSource: UserDatabaseDataSourceProtocol {

    private let secureStorage: SecureStorage

    init(secureStorage: SecureStorage) {
        self.secureStorage = secureStorage
    }

    func save(accessToken: String) {
        secureStorage.save(accessToken: accessToken)
    }

    var accessToken: String? {
        secureStorage.accessToken
    }

}

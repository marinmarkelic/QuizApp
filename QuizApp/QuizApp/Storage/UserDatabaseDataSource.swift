import Foundation

protocol UserDatabaseDataSourceProtocol {

    var accessToken: String? { get }

    func save(accessToken: String)

    func deleteAccessToken()

    func deleteUserInfo()

}

class UserDatabaseDataSource: UserDatabaseDataSourceProtocol {

    private let secureStorage: SecureStorage

    private let userDefaults = UserDefaults()

    private let usernameKey = "Username"

    var accessToken: String? {
        secureStorage.accessToken
    }

    init(secureStorage: SecureStorage) {
        self.secureStorage = secureStorage
    }

    func save(accessToken: String) {
        secureStorage.save(accessToken: accessToken)
    }

    func deleteAccessToken() {
        secureStorage.deleteAccessToken()
    }

    func deleteUserInfo() {
        userDefaults.set("", forKey: usernameKey)
    }

}

import Foundation

protocol UserDatabaseDataSourceProtocol {

    func save(accessToken: String)

    func save(userInfo: UserInfoDataSourceModel)

    func deleteAccessToken()

    func deleteUserInfo()

    var accessToken: String? { get }

    var userInfo: UserInfoDataSourceModel { get }

}

class UserDatabaseDataSource: UserDatabaseDataSourceProtocol {

    private let secureStorage: SecureStorage

    private let userDefaults = UserDefaults()

    private let usernameKey = "Username"

    var accessToken: String? {
        secureStorage.accessToken
    }

    var userInfo: UserInfoDataSourceModel {
        UserInfoDataSourceModel(username: userDefaults.string(forKey: usernameKey) ?? "")
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

    func save(userInfo: UserInfoDataSourceModel) {
        userDefaults.set(userInfo.username, forKey: usernameKey)
    }

}

struct UserInfoDataSourceModel {

    let username: String

}

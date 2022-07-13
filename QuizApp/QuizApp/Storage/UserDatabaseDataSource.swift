import Foundation

protocol UserDatabaseDataSourceProtocol {

    func save(accessToken: String)

    func save(userInfo: UserInfoRepoModel)

    func deleteAccessToken()

    var accessToken: String? { get }

    var userInfo: UserInfoDatabaseModel { get }

}

class UserDatabaseDataSource: UserDatabaseDataSourceProtocol {

    private let secureStorage: SecureStorage

    private let userDefaults = UserDefaults()

    init(secureStorage: SecureStorage) {
        self.secureStorage = secureStorage
    }

    func save(accessToken: String) {
        secureStorage.save(accessToken: accessToken)
    }

    func deleteAccessToken() {
        secureStorage.deleteAccessToken()
    }

    func save(userInfo: UserInfoRepoModel) {
        userDefaults.set(userInfo.username, forKey: "Username")
    }

    var accessToken: String? {
        secureStorage.accessToken
    }

    var userInfo: UserInfoDatabaseModel {
        UserInfoDatabaseModel(username: userDefaults.string(forKey: "Username") ?? "")
    }

}

struct UserInfoDatabaseModel {

    let username: String

}

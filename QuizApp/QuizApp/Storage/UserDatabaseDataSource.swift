import Foundation

protocol UserDatabaseDataSourceProtocol {

    func save(accessToken: String)

    func save(userInfo: UserInfoRepoModel)

    var accessToken: String? { get }

    var userInfo: UserInfoDatabaseModel { get }

}

class UserDatabaseDataSource: UserDatabaseDataSourceProtocol {

    private let secureStorage: SecureStorage

    init(secureStorage: SecureStorage) {
        self.secureStorage = secureStorage
    }

    func save(accessToken: String) {
        secureStorage.save(accessToken: accessToken)
    }

    func save(userInfo: UserInfoRepoModel) {
        UserDefaults().set(userInfo.username, forKey: "Username")
    }

    var accessToken: String? {
        secureStorage.accessToken
    }

    var userInfo: UserInfoDatabaseModel {
        UserInfoDatabaseModel(username: UserDefaults().string(forKey: "Username") ?? "")
    }

}

struct UserInfoDatabaseModel {

    let username: String

}

import CoreFoundation
protocol UserDatabaseDataSourceProtocol {

    func storeAccessToken(accessToken: String)

}

class UserDatabaseDataSource: UserDatabaseDataSourceProtocol {

    func storeAccessToken(accessToken: String) {
        SecureStorage.save(accessToken: accessToken)

        do {
            print(try SecureStorage.fetchAccessToken())
        } catch let error {
            print(error)
        }
    }

}

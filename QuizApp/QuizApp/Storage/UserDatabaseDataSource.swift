import CoreFoundation
protocol UserDatabaseDataSourceProtocol {

    func storeAccessToken(accessToken: String)

}

class UserDatabaseDataSource: UserDatabaseDataSourceProtocol {

    func storeAccessToken(accessToken: String) {
        do {
            try SecureStorage.save(accessToken: accessToken)
        } catch let error {
            print(error)
        }

        do {
            print(try SecureStorage.fetchAccessToken())
        } catch let error {
            print(error)
        }
    }
}

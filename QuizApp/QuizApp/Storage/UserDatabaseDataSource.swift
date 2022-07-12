import CoreFoundation
protocol UserDatabaseDataSourceProtocol {

    func save(accessToken: String)

}

class UserDatabaseDataSource: UserDatabaseDataSourceProtocol {

    func save(accessToken: String) {
        SecureStorage.save(accessToken: accessToken)

        do {
            print(try SecureStorage.fetchAccessToken())
        } catch let error {
            print(error)
        }
    }

}

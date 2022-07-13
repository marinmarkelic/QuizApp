import KeychainSwift

protocol SecureStorageProtocol {

    var accessToken: String? { get }

    func save(accessToken: String)

    func deleteAccessToken()

}

class SecureStorage: SecureStorageProtocol {

    private let keychain = KeychainSwift()

    private let accessTokenKey = "AccessToken"

    var accessToken: String? {
        keychain.get(accessTokenKey)
    }

    func save(accessToken: String) {
        keychain.set(accessToken, forKey: accessTokenKey)
    }

    func deleteAccessToken() {
        keychain.delete(accessTokenKey)
    }

}

import KeychainSwift

protocol SecureStorageProtocol {

    func save(accessToken: String)

    var accessToken: String? { get }

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

}

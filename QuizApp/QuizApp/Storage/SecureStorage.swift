import KeychainSwift

protocol SecureStorageProtocol {

    func save(accessToken: String)

    func fetchAccessToken() -> String?

}

class SecureStorage: SecureStorageProtocol {

    private let keychain = KeychainSwift()

    private let accessTokenKey = "AccessToken"

    func fetchAccessToken() -> String? {
        keychain.get(accessTokenKey)
    }

    func save(accessToken: String) {
        keychain.set(accessToken, forKey: accessTokenKey)
    }

}

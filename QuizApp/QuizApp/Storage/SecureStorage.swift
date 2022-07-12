import Foundation
import Security
import KeychainSwift

protocol SecureStorageProtocol {

    func save(accessToken: String)
    func fetchAccessToken() -> String?

}

class SecureStorage: SecureStorageProtocol {

    private let keychain = KeychainSwift()

    func fetchAccessToken() -> String? {
        keychain.get("AccessToken")
    }

    func save(accessToken: String) {
        keychain.set(accessToken, forKey: "AccessToken")
    }

}

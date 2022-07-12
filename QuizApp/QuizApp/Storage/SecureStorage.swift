import Foundation
import Security
import KeychainSwift

protocol SecureStorageProtocol {

    func save(accessToken: String)
    func fetchAccessToken() -> String?

}

class SecureStorage: SecureStorageProtocol {

    func fetchAccessToken() -> String? {
        let keychain = KeychainSwift()
        return keychain.get("AccessToken")
    }

    func save(accessToken: String) {
        let keychain = KeychainSwift()
        keychain.set(accessToken, forKey: "AccessToken")
    }

}

enum KeychainError: Error {

    case itemNotFound

}

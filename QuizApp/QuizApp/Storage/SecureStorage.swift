import Foundation
import Security
import KeychainSwift

protocol SecureStorageProtocol {

    static func save(accessToken: String)
    static func fetchAccessToken() throws -> String

}

class SecureStorage: SecureStorageProtocol {

    static func fetchAccessToken() throws -> String {
        let keychain = KeychainSwift()

        guard let accessToken = keychain.get("AccessToken") else {
            throw KeychainError.itemNotFound
        }

        return accessToken
    }

    static func save(accessToken: String) {
        let keychain = KeychainSwift()
        keychain.set(accessToken, forKey: "AccessToken")
    }

}

enum KeychainError: Error {

    case itemNotFound

}

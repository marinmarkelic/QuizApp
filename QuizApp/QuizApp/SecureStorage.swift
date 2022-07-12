import Security
import Foundation

protocol SecureStorageProtocol {

    static func save(accessToken: String) throws
    static func fetchAccessToken() throws -> String

}

class SecureStorage: SecureStorageProtocol {
    static func fetchAccessToken() throws -> String {
        let query: [String: AnyObject] = [
            kSecAttrService as String: "AccessToken" as AnyObject,
            kSecClass as String: kSecClassKey,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue
        ]

        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &itemCopy
        )

        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }

        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }

        guard let data = itemCopy as? Data else {
            throw KeychainError.invalidItemFormat
        }

        let accessToken = String(decoding: data, as: UTF8.self)

        return accessToken
    }

    static func save(accessToken: String) throws {
        let query = [
            kSecAttrService: "AccessToken",
            kSecClass: kSecClassKey,
            kSecValueData: Data(accessToken.utf8)
        ] as [CFString : Any]

        let status = SecItemAdd(query as CFDictionary, nil)

        if status == errSecDuplicateItem {
            throw KeychainError.duplicateItem
        }

        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }

}

enum KeychainError: Error {

    case duplicateItem
    case itemNotFound
    case invalidItemFormat
    case unexpectedStatus(OSStatus)

}

protocol UserNetworkClientProtocol {

    var userInfo: UserInfoNetworkDataModel { get async throws }

    func save(name: String) async throws -> UserInfoNetworkDataModel

}

class UserNetworkClient: UserNetworkClientProtocol {

    private let networkClient: NetworkClient

    private let accountUrlExtension = "/v1/account"

    var userInfo: UserInfoNetworkDataModel {
        get async throws {
            try await networkClient.get(path: accountUrlExtension)
        }
    }

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func save(name: String) async throws -> UserInfoNetworkDataModel {
        try await networkClient.patch(
            path: accountUrlExtension,
            body: UserInfoNetworkRequestModel(name: name))
    }

}

struct UserInfoNetworkDataModel: Decodable {

    let email: String
    let id: Int
    let name: String

}

struct UserInfoNetworkRequestModel: Encodable {

    let name: String

}

protocol UserNetworkClientProtocol {

    var userInfo: UserInfoNetworkDataModel { get async throws }

    func save(name: String) async throws -> UserInfoNetworkDataModel

}

class UserNetworkClient: UserNetworkClientProtocol {

    private let networkClient: NetworkClient

    private let accountPath = "/v1/account"

    var userInfo: UserInfoNetworkDataModel {
        get async throws {
            try await networkClient.get(path: accountPath)
        }
    }

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func save(name: String) async throws -> UserInfoNetworkDataModel {
        try await networkClient.patch(
            path: accountPath,
            body: UserInfoNetworkRequestModel(name: name))
    }

}

struct UserInfoNetworkDataModel: Decodable {

    let id: Int
    let email: String
    let name: String

}

struct UserInfoNetworkRequestModel: Encodable {

    let name: String

}

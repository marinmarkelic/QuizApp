protocol UserNetworkClientProtocol {

    var userInfo: UserInfoNetworkDataModel { get async throws }

//    func save(name: String) async throws

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

//    func save(name: String) async throws{
//        try await networkClient.
//    }

}

struct UserInfoNetworkDataModel: Decodable {

    let name: String

}

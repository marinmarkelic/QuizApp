import Foundation

protocol CheckNetworkClientProtocol {

    func check() async throws

}

class CheckNetworkClient: CheckNetworkClientProtocol {

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func check() async throws {
        try await networkClient.get(path: "/v1/check")
    }

}

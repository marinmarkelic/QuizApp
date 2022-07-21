import Foundation

protocol CheckNetworkClientProtocol {

    func check() async throws

}

class CheckNetworkClient: CheckNetworkClientProtocol {

    private let networkClient: NetworkClient

    private let checkPath = "/v1/check"

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func check() async throws {
        try await networkClient.get(path: checkPath)
    }

}

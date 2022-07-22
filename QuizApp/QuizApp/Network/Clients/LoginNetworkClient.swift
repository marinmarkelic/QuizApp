import Foundation

protocol LoginNetworkClientProtocol {

    func logIn(username: String, password: String) async throws -> LoginResponseNetworkDataModel

}

class LoginNetworkClient: LoginNetworkClientProtocol {

    private let networkClient: NetworkClient

    private let loginPath = "/v1/login"

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func logIn(username: String, password: String) async throws -> LoginResponseNetworkDataModel {
        try await networkClient.post(
            path: loginPath,
            body: LoginRequestNetworkDataModel(username: username, password: password))
    }

}

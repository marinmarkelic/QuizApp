import Foundation

struct LoginRequest: Encodable {

    let username: String
    let password: String

}

struct LoginResponse: Decodable {

    let accessToken: String

}

protocol LoginNetworkClientProtocol {

    func logIn(username: String, password: String) async throws -> LoginResponse

}

class LoginNetworkClient: LoginNetworkClientProtocol {

    private let networkClient: NetworkClient

    private let loginPath = "/v1/login"

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func logIn(username: String, password: String) async throws -> LoginResponse {
        try await networkClient.post(
            path: loginPath,
            body: LoginRequest(username: username, password: password))
    }

}

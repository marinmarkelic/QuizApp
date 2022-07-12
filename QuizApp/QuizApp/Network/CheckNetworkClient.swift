import Foundation

protocol CheckNetworkClientProtocol {

    func check() async throws

}

class CheckNetworkClient: NetworkClient, CheckNetworkClientProtocol {

    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func check() async throws {
        guard let url = URL(string: "\(baseUrl)/v1/check") else {
            throw RequestError.invalidURLError
        }

        guard let accessToken = SecureStorage().fetchAccessToken() else {
            throw CheckNetworkError.noAccessTokenError
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"

        let (_, _) = try await handle(urlRequest: urlRequest)
    }

}

struct CheckRequest: Encodable {

    let accessToken: String

}

enum CheckNetworkError: Error {

    case noAccessTokenError

}

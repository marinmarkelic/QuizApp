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

class LoginNetworkClient: NetworkClient, LoginNetworkClientProtocol {

    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func logIn(username: String, password: String) async throws -> LoginResponse {
        guard let url = URL(string: "\(baseUrl)/v1/login") else { throw RequestError.invalidURLError }

        guard let jsonData = try? JSONEncoder().encode(LoginRequest(username: username, password: password)) else {
            throw RequestError.dataCodingError
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData

        let (data, _) = try await handle(urlRequest: urlRequest)

        guard let value = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
            throw RequestError.dataCodingError
        }

        return value
    }

}

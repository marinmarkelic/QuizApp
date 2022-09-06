import Foundation

class NetworkClient {

    private let baseUrl: String
    private let secureStorage: SecureStorage

    private var isConnected: Bool {
        Reachability.isConnectedToNetwork()
    }

    init(secureStorage: SecureStorage, baseUrl: String) {
        self.secureStorage = secureStorage
        self.baseUrl = baseUrl
    }

    func get(path: String) async throws {
        if !isConnected { throw RequestError.disconnectedError }

        guard let url = URL(string: "\(baseUrl)\(path)") else {
            throw RequestError.invalidURLError
        }

        let accessToken = secureStorage.accessToken ?? ""

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"

        _ = try await handle(urlRequest: urlRequest)
    }

    func get<Response: Decodable>(path: String) async throws -> Response {
        if !isConnected { throw RequestError.disconnectedError }

        guard let url = URL(string: "\(baseUrl)\(path)") else {
            throw RequestError.invalidURLError
        }

        let accessToken = secureStorage.accessToken ?? ""

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"

        let (data, _) = try await handle(urlRequest: urlRequest)

        guard let value = try? JSONDecoder().decode(Response.self, from: data) else {
            throw RequestError.dataCodingError
        }

        return value
    }

    func patch<RequestModel: Encodable, Response: Decodable>(
        path: String,
        body: RequestModel
    ) async throws -> Response {
        if !isConnected { throw RequestError.disconnectedError }

        guard let url = URL(string: "\(baseUrl)\(path)") else {
            throw RequestError.invalidURLError
        }

        guard let jsonData = try? JSONEncoder().encode(body) else {
            throw RequestError.dataCodingError
        }

        let accessToken = secureStorage.accessToken ?? ""

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "PATCH"
        urlRequest.httpBody = jsonData

        let (data, _) = try await handle(urlRequest: urlRequest)

        guard let value = try? JSONDecoder().decode(Response.self, from: data) else {
            throw RequestError.dataCodingError
        }

        return value
    }

    func post<RequestModel: Encodable, Response: Decodable>(
        path: String,
        body: RequestModel
    ) async throws -> Response {
        if !isConnected { throw RequestError.disconnectedError }

        guard let url = URL(string: "\(baseUrl)\(path)") else {
            throw RequestError.invalidURLError
        }

        guard let jsonData = try? JSONEncoder().encode(body) else {
            throw RequestError.dataCodingError
        }

        let accessToken = secureStorage.accessToken ?? ""

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData

        let (data, _) = try await handle(urlRequest: urlRequest)

        guard let value = try? JSONDecoder().decode(Response.self, from: data) else {
            throw RequestError.dataCodingError
        }

        return value
    }

    func handle(urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        if !isConnected { throw RequestError.disconnectedError }

        guard let (data, response) = try? await URLSession.shared.data(for: urlRequest) else {
            throw RequestError.serverError
        }

        if
            let httpResponse = response as? HTTPURLResponse,
            (300...503).contains(httpResponse.statusCode)
        {
            switch httpResponse.statusCode {
            case 401:
                throw RequestError.unauthorisedError
            case 403:
                throw RequestError.forbiddenError
            case 404:
                throw RequestError.notFoundError
            default:
                throw RequestError.serverError
            }
        }

        return (data, response)
    }

}

import Foundation
protocol CheckNetworkClientProtocol {

    func check() async throws

}

class CheckNetworkClient: CheckNetworkClientProtocol {

    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func check() async throws {
        guard let
                url = URL(string: "\(baseUrl)/v1/check")
        else { throw RequestError.invalidURLError }

        guard let accessToken = SecureStorage().fetchAccessToken() else {
            throw CheckNetworkError.noAccessTokenError
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"

        guard let (_, response) = try? await URLSession.shared.data(for: urlRequest) else {
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
    }

}

struct CheckRequest: Encodable {

    let accessToken: String

}

enum CheckNetworkError: Error {

    case noAccessTokenError

}

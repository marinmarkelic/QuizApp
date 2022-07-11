import Foundation

struct LoginRequest: Encodable {

    let username: String
    let passsword: String

}

struct LoginResponse: Decodable {

    let accessToken: String

}

protocol LoginClientProtocol {

    func logIn(username: String, password: String) async throws -> LoginResponse

}

class LoginClient: LoginClientProtocol {

    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    private let loginUrl = "https://five-ios-quiz-app.herokuapp.com/api/v1/login"

    func logIn(username: String, password: String) async throws -> LoginResponse {
        guard let url = URL(string: "\(baseUrl)/v1/login") else { throw RequestError.invalidURLError }

        guard let jsonData = try? JSONEncoder().encode(LoginRequest(username: username, passsword: password)) else {
            throw RequestError.dataDecodingError
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData

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

        guard let value = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
            throw RequestError.dataDecodingError
        }

        return value
    }

}

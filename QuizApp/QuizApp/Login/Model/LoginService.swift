import Foundation

class LoginService {

    private let loginUrl = "https://five-ios-quiz-app.herokuapp.com/api/v1/login"

    func checkLoginInfo(username: String, password: String) async throws -> [String: String] {
        guard let url = URL(string: loginUrl) else {
            throw RequestError.invalidURLError
        }

        let json = [
            "username": username,
            "password": password]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json)

            var urlRequest = URLRequest(url: url)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = jsonData

            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            if let httpResponse = response as? HTTPURLResponse,
                (400...500).contains(httpResponse.statusCode) {
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

            guard let value = try? JSONSerialization.jsonObject(with: data) as? [String: String] else {
                throw RequestError.dataDecodingError
            }

            return value

        } catch {
            throw RequestError.urlRequestError
        }
    }

}

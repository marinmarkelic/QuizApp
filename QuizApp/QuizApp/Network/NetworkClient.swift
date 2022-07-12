import Foundation

class NetworkClient {

    func handle(urlRequest: URLRequest) async throws -> (Data, URLResponse) {
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

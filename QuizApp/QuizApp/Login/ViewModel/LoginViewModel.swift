import Combine
import UIKit

class LoginViewModel {

    @Published var isLoginButtonEnabled = false
    @Published var errorText = ""

    private var email = ""
    private var password = ""

    func updatedEmail(with text: String) {
        email = text
        checkInputValidity()
    }

    func updatedPassword(with text: String) {
        password = text
        checkInputValidity()
    }

    func pressedLoginButton() {
        if isValidEmail(email) {
            errorText = ""

            Task {
                do {
                    let result = try await checkLoginInfo()
                    print(result["accessToken"] ?? "--")

                } catch let error as RequestError {
                    DispatchQueue.main.async { [weak self] in
                        var errorStr: String

                        switch error {
                        case .notFoundError:
                            errorStr = "404 Not Found"
                        case .forbiddenError:
                            errorStr = "403 Forbidden"
                        case .unauthorisedError:
                            errorStr = "Username or password is wrong"
                        default:
                            errorStr = "Error logging in"
                        }

                        self?.errorText = errorStr
                    }
                }
            }

        } else {
            errorText = "Invalid Email"
        }
    }

    private func checkLoginInfo() async throws -> [String: String] {
        return try await LoginService().checkLoginInfo(username: email, password: password)
    }

    private func checkInputValidity() {
        isLoginButtonEnabled = !password.isEmpty && !email.isEmpty
        errorText = ""
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}

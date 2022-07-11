import Combine
import UIKit

class LoginViewModel {

    @Published var isLoginButtonEnabled = false
    @Published var errorText = ""

    private var email = ""
    private var password = ""

    private let loginClient: LoginClientProtocol

    init(loginClient: LoginClientProtocol) {
        self.loginClient = loginClient
    }

    func updatedEmail(with text: String) {
        email = text
        checkInputValidity()
    }

    func updatedPassword(with text: String) {
        password = text
        checkInputValidity()
    }

    @MainActor
    func pressedLoginButton() {
        errorText = ""
        Task {
            do {
                let response = try await loginClient.logIn(username: email, password: password)
                print(response.accessToken)
            } catch let error as RequestError {
                showError(error)
            }
        }
    }

    private func showError(_ error: RequestError) {
        switch error {
        case .unauthorisedError:
            errorText = "Invalid credentials!"
        default:
            errorText = "Error logging in!"
        }
    }

    private func checkInputValidity() {
        isLoginButtonEnabled = !password.isEmpty && isValidEmail(email)
        errorText = ""
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}

import Combine
import UIKit

class LoginViewModel {

    private let appRouter: AppRouterProtocol
    private let loginUseCase: LoginUseCaseProtocol

    @Published var isLoginButtonEnabled = false
    @Published var errorText = ""

    private var email = ""
    private var password = ""

    init(appRouter: AppRouterProtocol, loginUseCase: LoginUseCaseProtocol) {
        self.appRouter = appRouter
        self.loginUseCase = loginUseCase
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
                _ = try await loginUseCase.logIn(username: email, password: password)

                appRouter.showHome()
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

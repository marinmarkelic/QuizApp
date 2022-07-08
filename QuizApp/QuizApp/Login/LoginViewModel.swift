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

    private func checkInputValidity() {
        isLoginButtonEnabled = !password.isEmpty && !email.isEmpty

        if isValidEmail(email) {
            errorText = ""
        } else {
            errorText = "Invalid Email"
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}

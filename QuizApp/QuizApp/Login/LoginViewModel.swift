import Combine

class LoginViewModel {

    @Published var isLoginButtonEnabled = false

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
    }

}

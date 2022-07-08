import Combine

class LoginViewModel {

    @Published var isLoginButtonEnabled = false

    private var isLoginEmailValid = false
    private var isLoginPasswordValid = false

    private var email = ""
    private var password = ""

    func updatedEmail(withText text: String) {
        email = text
        checkInputValidity()
    }

    func updatedPassword(withText text: String) {
        password = text
        checkInputValidity()
    }

    private func checkInputValidity() {
        isLoginButtonEnabled = !password.isEmpty && !email.isEmpty
    }

}

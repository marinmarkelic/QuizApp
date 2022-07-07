import UIKit

class LoginButton: UIButton {

    var hasValidInputForEmail = false
    var hasValidInputForPassword = false

    override init(frame: CGRect) {
        super.init(frame: frame)

        styleViews()
    }

    func styleViews() {
        layer.cornerRadius = 20
        clipsToBounds = true

        setTitle("Login", for: .normal)
        setTitleColor(UIColor(red: 99/255, green: 41/255, blue: 222/255, alpha: 1.0), for: .normal)

        enableButtonIfPossible()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func enableButtonIfPossible() {
        if hasValidInputForEmail && hasValidInputForPassword {
            backgroundColor = .white
            isEnabled = true
        } else {
            backgroundColor = UIColor(red: 176/255, green: 167/255, blue: 204/255, alpha: 1.0)
            isEnabled = false
        }
    }

}

extension LoginButton: EmailViewDelegate, PasswordViewDelegate {

    func passwordViewText(_ passwordView: PasswordView, hasValidInput: Bool) {
        hasValidInputForPassword = hasValidInput
        enableButtonIfPossible()
    }

    func emailViewText(_ emailView: EmailView, hasValidInput: Bool) {
        hasValidInputForEmail = hasValidInput
        enableButtonIfPossible()
    }

}

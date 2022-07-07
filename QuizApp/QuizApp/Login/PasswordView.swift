import UIKit
import SnapKit

class PasswordView: TextFieldView {

    var delegate: PasswordViewDelegate!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setPlaceholder(withText: "Password")
        setSecure(true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let hasValidInput = range.lowerBound != 0 || range.upperBound <= 0
        delegate.passwordViewText(self, hasValidInput: hasValidInput)
        visibilityButton.isHidden = !hasValidInput

        return true
    }

}

protocol PasswordViewDelegate: AnyObject {

    func passwordViewText(_ passwordView: PasswordView, hasValidInput: Bool)

}

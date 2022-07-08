import UIKit
import SnapKit

class PasswordView: TextFieldView {

    weak var delegate: PasswordViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setPlaceholder(with: "Password")
        setSecure(true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    override func textFieldDidChange(sender: UITextField) {
        guard let text=sender.text else { return }

        delegate?.passwordViewText(self, text: text)

        toggleVisibilityButton(isVisible: !text.isEmpty)
    }

}

protocol PasswordViewDelegate: AnyObject {

    func passwordViewText(_ passwordView: PasswordView, text: String)

}

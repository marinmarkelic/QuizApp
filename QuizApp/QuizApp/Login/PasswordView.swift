import UIKit
import SnapKit

class PasswordView: UIView {

    var delegate: PasswordViewDelegate!

    var textField: UITextField!
    var visibilityButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createViews() {
        textField = UITextField()
        visibilityButton = UIButton()

        addSubview(textField)
        addSubview(visibilityButton)
    }

    func styleViews() {
        backgroundColor = .white.withAlphaComponent(0.3)
        layer.cornerRadius = 20
        layer.borderColor =  UIColor.white.cgColor
        clipsToBounds = true

        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        textField.textColor = .white
        textField.isSecureTextEntry = true

        visibilityButton.tintColor = .white
        visibilityButton.setBackgroundImage(UIImage(systemName: "eye.fill"), for: .normal)
        visibilityButton.isHidden = true
        visibilityButton.addTarget(self, action: #selector(visibilityButtonTap), for: .touchUpInside)
    }

    @objc
    func visibilityButtonTap() {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }

    func defineLayoutForViews() {
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(21)
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-10)
        }

        visibilityButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-18)
        }
    }

}

extension PasswordView: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        layer.borderWidth = 1
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        layer.borderWidth = 0
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String)
    -> Bool {
        if range.lowerBound == 0 && range.upperBound > 0 {
            visibilityButton.isHidden = true
            delegate.passwordViewText(self, hasValidInput: false)
        } else {
            visibilityButton.isHidden = false
            delegate.passwordViewText(self, hasValidInput: true)
        }

        return true
    }

}

protocol PasswordViewDelegate: AnyObject {

    func passwordViewText(_ passwordView: PasswordView, hasValidInput: Bool)

}

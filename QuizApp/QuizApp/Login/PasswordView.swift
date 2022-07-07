import UIKit
import SnapKit

class PasswordView: UIView {

    var delegate: PasswordViewDelegate!

    private var textField: UITextField!
    private var visibilityButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func visibilityButtonTap() {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }

}

extension PasswordView: ConstructViewsProtocol {

    func createViews() {
        textField = UITextField()
        addSubview(textField)

        visibilityButton = UIButton()
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

    func defineLayoutForViews() {
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(21)
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
        }

        visibilityButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(18)
            $0.width.equalTo(20)
            $0.height.equalTo(18)
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
        replacementString string: String
    ) -> Bool {
        let hasValidInput = range.lowerBound != 0 && range.upperBound <= 0
        delegate.passwordViewText(self, hasValidInput: hasValidInput)

        return true
    }

}

protocol PasswordViewDelegate: AnyObject {

    func passwordViewText(_ passwordView: PasswordView, hasValidInput: Bool)

}

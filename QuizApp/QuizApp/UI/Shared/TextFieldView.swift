import UIKit
import SnapKit

class TextFieldView: UIView {

    var visibilityButton: UIButton!

    private var textField: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setPlaceholder(with text: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
    }

    func setSecure(_ bool: Bool) {
        textField.isSecureTextEntry = bool
    }

}

extension TextFieldView: ConstructViewsProtocol {

    func createViews() {
        textField = UITextField()
        addSubview(textField)

        visibilityButton = UIButton()
        addSubview(visibilityButton)
    }

    func styleViews() {
        backgroundColor = .white.withAlphaComponent(0.3)
        layer.cornerRadius = 20
        layer.borderColor = UIColor.white.cgColor
        clipsToBounds = true

        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = .white
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        visibilityButton.tintColor = .white
        visibilityButton.setBackgroundImage(UIImage(systemName: "eye.fill"), for: .normal)
        visibilityButton.isHidden = true
        visibilityButton.addTarget(self, action: #selector(visibilityButtonTap), for: .touchUpInside)
    }

    func defineLayoutForViews() {
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
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

    @objc
    private func visibilityButtonTap() {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }

    func toggleVisibilityButton(isVisible: Bool) {
        visibilityButton.isHidden = !isVisible
    }

    @objc
    func textFieldDidChange(sender: UITextField) {}

}

extension TextFieldView: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        layer.borderWidth = 1
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        layer.borderWidth = 0
    }

}

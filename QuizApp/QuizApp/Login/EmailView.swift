import UIKit
import SnapKit

class EmailView: UIView {

    var delegate: EmailViewDelegate!

    var textField: UITextField!

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

        addSubview(textField)
    }

    func styleViews() {
        backgroundColor = .white.withAlphaComponent(0.3)
        layer.cornerRadius = 20
        layer.borderColor = UIColor.white.cgColor
        clipsToBounds = true

        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
        textField.textColor = .white
    }

    func defineLayoutForViews() {
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(21)
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }

}

extension EmailView: UITextFieldDelegate {

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
            delegate.emailViewText(self, hasValidInput: false)
        } else {
            delegate.emailViewText(self, hasValidInput: true)
        }

        return true
    }

}

protocol EmailViewDelegate: AnyObject {

    func emailViewText(_ emailView: EmailView, hasValidInput: Bool)

}

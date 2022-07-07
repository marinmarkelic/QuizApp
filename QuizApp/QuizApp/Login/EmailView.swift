import UIKit
import SnapKit

class EmailView: TextFieldView {

    var delegate: EmailViewDelegate!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setPlaceholder(withText: "Email")
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
        delegate.emailViewText(self, hasValidInput: hasValidInput)

        return true
    }

}

protocol EmailViewDelegate: AnyObject {

    func emailViewText(_ emailView: EmailView, hasValidInput: Bool)

}

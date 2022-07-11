import UIKit
import SnapKit

class EmailView: TextFieldView {

    weak var delegate: EmailViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setPlaceholder(with: "Email")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    override func textFieldDidChange(sender: UITextField) {
        guard let text=sender.text else { return }

        delegate?.emailViewText(self, text: text)
    }

}

protocol EmailViewDelegate: AnyObject {

    func emailViewText(_ emailView: EmailView, text: String)

}

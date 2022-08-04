import UIKit
import SnapKit

class PasswordView: TextFieldView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setPlaceholder(with: "Password")
        setSecure(true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

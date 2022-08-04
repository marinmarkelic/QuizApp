import UIKit
import SnapKit

class EmailView: TextFieldView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setPlaceholder(with: "Email")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

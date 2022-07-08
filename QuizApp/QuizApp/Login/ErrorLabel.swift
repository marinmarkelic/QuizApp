import UIKit

class ErrorLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)

        styleViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setErrorText(with text: String) {
        self.text = text
    }

}

extension ErrorLabel: ConstructViewsProtocol {
    func createViews() {}

    func styleViews() {
        isHidden = true
        textColor = .red
    }

    func defineLayoutForViews() {}

}

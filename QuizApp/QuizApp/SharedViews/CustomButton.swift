import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        styleViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CustomButton: ConstructViewsProtocol {

    func createViews() {}

    func styleViews() {
        layer.cornerRadius = 23
        clipsToBounds = true
    }

    func defineLayoutForViews() {}

}

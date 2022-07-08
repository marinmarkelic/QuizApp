import UIKit

class LoginButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        styleViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func buttonClicked(sender: UIButton) {}

}

extension LoginButton: ConstructViewsProtocol {

    func createViews() {}

    func defineLayoutForViews() {}

    func styleViews() {
        layer.cornerRadius = 20
        clipsToBounds = true

        setTitle("Login", for: .normal)
        setTitleColor(UIColor(red: 99 / 255, green: 41 / 255, blue: 222 / 255, alpha: 1.0), for: .normal)
        backgroundColor = .white.withAlphaComponent(0.6)
        isEnabled = false
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }

}

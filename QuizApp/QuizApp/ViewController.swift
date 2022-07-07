import UIKit

class ViewController: UIViewController {

    var gradientBackground: CAGradientLayer!

    init() {
        super.init(nibName: nil, bundle: nil)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildViews() {
        gradientBackground = CAGradientLayer()
        gradientBackground.frame = view.bounds
        gradientBackground.colors = [
            CGColor(red: 116/255, green: 79/255, blue: 163/255, alpha: 1.0),
            CGColor(red: 39/255, green: 47/255, blue: 118/255, alpha: 1.0)]

        view.layer.insertSublayer(gradientBackground, at: 0)
    }
}

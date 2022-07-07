import UIKit
import SnapKit

class LoginViewController: UIViewController {

    var gradientBackground: CAGradientLayer!

    var mainView: UIView!

    var label: UILabel!

    var stackView: UIStackView!

    init() {
        super.init(nibName: nil, bundle: nil)

        buildViews()
        addConstraints()
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

        mainView = UIView()

        label = UILabel()
        label.text = "PopQuiz"
        label.textColor = .white
        label.font = UIFont(descriptor: UIFontDescriptor(name: "SourceSansPro", size: 32), size: 32)

        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 18

        addViewsToStackView()

        view.addSubview(mainView)
        mainView.addSubview(label)
        mainView.addSubview(stackView)
    }

    func addViewsToStackView() {
    }

    func addConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        label.snp.makeConstraints {
            $0.centerX.equalTo(mainView)
        }

        stackView.snp.makeConstraints {
            $0.centerX.equalTo(mainView)
            $0.top.equalTo(label.snp.bottom).offset(20)
        }
    }
}

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    var gradientView: GradientView!

    var mainView: UIView!
    var label: UILabel!

    var stackView: UIStackView!

    var emailView: EmailView!
    var passwordView: PasswordView!
    var loginButton: LoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        addConstraints()
    }

    func buildViews() {
        gradientView = GradientView()
//        gradientBackground.frame = view.bounds
//        gradientBackground.colors = [
//            CGColor(red: 116/255, green: 79/255, blue: 163/255, alpha: 1.0),
//            CGColor(red: 39/255, green: 47/255, blue: 118/255, alpha: 1.0)]
//        gradientBackground.frame = view.bounds
//
//        view.layer.insertSublayer(gradientBackground, at: 0)
//        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

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

        view.addSubview(gradientView)
        gradientView.addSubview(mainView)
        mainView.addSubview(label)
        mainView.addSubview(stackView)
    }

    func addViewsToStackView() {
        emailView = EmailView()
        passwordView = PasswordView()
        loginButton = LoginButton()

        emailView.delegate = loginButton
        passwordView.delegate = loginButton

        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        stackView.addArrangedSubview(loginButton)
    }

    func addConstraints() {
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        label.snp.makeConstraints {
            $0.centerX.equalTo(gradientView)
        }

        stackView.snp.makeConstraints {
            $0.centerX.equalTo(gradientView)
            $0.top.equalTo(label.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-32)
        }
    }
}

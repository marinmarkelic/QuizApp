import UIKit
import SnapKit

class LoginViewController: UIViewController {

    var gradientView: GradientView!
    var mainView: UIView!

    var scrollView: UIScrollView!
    var contentView: UIView!

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

        mainView = UIView()

        scrollView = UIScrollView()
        contentView = UIView()

        label = UILabel()
        label.text = "PopQuiz"
        label.textColor = .white
        label.font = UIFont(descriptor: UIFontDescriptor(name: "SourceSansPro-Regular", size: 32), size: 32)

        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 18

        addViewsToStackView()

        view.addSubview(gradientView)
        gradientView.addSubview(mainView)
        mainView.addSubview(label)
        mainView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
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
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalTo(gradientView)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.centerX.equalTo(gradientView)
            $0.centerY.equalTo(mainView)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-32)
            $0.bottom.equalToSuperview()
        }
    }
}

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    private var gradientView: GradientView!
    private var mainView: UIView!

    private var scrollView: UIScrollView!
    private var contentView: UIView!

    private var label: UILabel!

    private var stackView: UIStackView!

    private var emailView: EmailView!
    private var passwordView: PasswordView!
    private var loginButton: LoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        addActions()
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    private func addActions() {
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
        view.addGestureRecognizer(tapGestureBackground)
    }

    @objc
    private func backgroundTapped(_ sender: UITapGestureRecognizer) {
        emailView.endEditing(true)
        passwordView.endEditing(true)
    }

}

extension LoginViewController: ConstructViewsProtocol {

    func createViews() {
        gradientView = GradientView()
        view.addSubview(gradientView)

        mainView = UIView()
        gradientView.addSubview(mainView)

        scrollView = UIScrollView()
        mainView.addSubview(scrollView)

        contentView = UIView()
        scrollView.addSubview(contentView)

        label = UILabel()
        mainView.addSubview(label)

        stackView = UIStackView()
        contentView.addSubview(stackView)

        emailView = EmailView()
        stackView.addArrangedSubview(emailView)
        passwordView = PasswordView()
        stackView.addArrangedSubview(passwordView)
        loginButton = LoginButton()
        stackView.addArrangedSubview(loginButton)
    }

    func styleViews() {
        label.text = "PopQuiz"
        label.textColor = .white
        label.font = UIFont(descriptor: UIFontDescriptor(name: "SourceSansPro-Regular", size: 32), size: 32)

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 18

        emailView.delegate = loginButton
        passwordView.delegate = loginButton
    }

    func defineLayoutForViews() {
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
            $0.center.equalTo(gradientView)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().inset(32)
            $0.bottom.equalToSuperview()
        }
    }

}

import Combine
import UIKit
import SnapKit

class LoginViewController: UIViewController {

    private let viewModel: LoginViewModel

    private var hasValidInputForEmail = false
    private var hasValidInputForPassword = false

    private var gradientView: GradientView!
    private var mainView: UIView!

    private var scrollView: UIScrollView!
    private var contentView: UIView!

    private var label: UILabel!

    private var stackView: UIStackView!

    private var emailView: EmailView!
    private var passwordView: PasswordView!
    private var loginButton: LoginButton!

    private var errorLabel: ErrorLabel!

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
        bindViews()
        bindViewModel()
    }

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bindViews() {
        view
            .tap
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.emailView.endEditing(true)
                self.passwordView.endEditing(true)
            }
            .store(in: &cancellables)

        loginButton
            .tap
            .sink { [weak self] _ in
                self?.viewModel.pressedLoginButton()
            }
            .store(in: &cancellables)

        emailView
            .text
            .sink { [weak self] text in
                self?.viewModel.updatedEmail(with: text)
            }
            .store(in: &cancellables)

        passwordView
            .text
            .sink { [weak self] text in
                self?.viewModel.updatedPassword(with: text)
            }
            .store(in: &cancellables)
    }

    private func bindViewModel() {
        viewModel
            .$isLoginButtonEnabled
            .sink { [weak self] isLoginEnabled in
                self?.redrawButtons(shouldEnable: isLoginEnabled)
            }
            .store(in: &cancellables)

        viewModel
            .$errorText
            .removeDuplicates()
            .sink { [weak self] errorText in
                self?.showErrorText(with: errorText)
            }
            .store(in: &cancellables)
    }

    private func showErrorText(with errorText: String) {
        errorLabel.setErrorText(errorText)

        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.errorLabel.isHidden = errorText.isEmpty

                if errorText.isEmpty {
                    self.stackView.setCustomSpacing(35, after: self.passwordView)
                } else {
                    self.stackView.setCustomSpacing(20, after: self.passwordView)
                }
            })
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

        errorLabel = ErrorLabel()
        stackView.addArrangedSubview(errorLabel)

        loginButton = LoginButton()
        stackView.addArrangedSubview(loginButton)
    }

    func styleViews() {
        label.text = "PopQuiz"
        label.textColor = .white
        label.font = .heading1

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 18
        stackView.setCustomSpacing(35, after: passwordView)
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
            $0.centerX.equalTo(gradientView)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().inset(32)
            $0.bottom.equalToSuperview()
        }

        passwordView.snp.makeConstraints {
            $0.centerY.equalTo(gradientView)
        }
    }

    private func redrawButtons(shouldEnable: Bool) {
        if shouldEnable {
            loginButton.backgroundColor = .white
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = .white.withAlphaComponent(0.6)
            loginButton.isEnabled = false
        }
    }

}

import UIKit
import SnapKit

class UserViewController: UIViewController {

    private var userViewModel: UserViewModel

    private var gradientView: GradientView!

    private var mainView: UIView!

    private var usernameLabel: UILabel!
    private var usernameTextField: UITextField!

    private var nameLabel: UILabel!
    private var nameTextField: UITextField!

    private var button: CustomButton!

    init(
        appRouter: AppRouterProtocol,
        userUseCase: UserUseCaseProtocol,
        logoutUseCase: LogOutUseCaseProtocol
    ) {
        self.userViewModel = UserViewModel(
            appRouter: appRouter,
            userUseCase: userUseCase,
            logoutUseCase: logoutUseCase)

        super.init(nibName: nil, bundle: nil)

        styleTabBarItem()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
        addActions()
        fetchData()
    }

    @objc
    private func pressedLogoutButton() {
        userViewModel.logOut()
    }

    private func addActions() {
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        view.addGestureRecognizer(tapGestureBackground)
    }

    @objc
    private func backgroundTapped(_ sender: UITapGestureRecognizer) {
        usernameTextField.endEditing(true)
        nameTextField.endEditing(true)
    }

    @objc
    private func textFieldEndedEditing() {
        Task {
            await userViewModel.save(
                username: usernameTextField.text ?? "",
                name: nameTextField.text ?? "")
        }
    }

    private func styleTabBarItem() {
        let config = UIImage.SymbolConfiguration(scale: .medium)

        tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape", withConfiguration: config),
            selectedImage: UIImage(systemName: "gearshape.fill", withConfiguration: config))
    }

    private func fetchData() {
        Task {
            usernameTextField.text = await userViewModel.username
            nameTextField.text = await userViewModel.name
        }
    }

}

extension UserViewController: ConstructViewsProtocol {

    func createViews() {
        gradientView = GradientView()
        view.addSubview(gradientView)

        mainView = UIView()
        gradientView.addSubview(mainView)

        usernameLabel = UILabel()
        mainView.addSubview(usernameLabel)

        usernameTextField = UITextField()
        mainView.addSubview(usernameTextField)

        nameLabel = UILabel()
        mainView.addSubview(nameLabel)

        nameTextField = UITextField()
        mainView.addSubview(nameTextField)

        button = CustomButton()
        mainView.addSubview(button)
    }

    func styleViews() {
        usernameLabel.text = "USERNAME"
        usernameLabel.font = UIFont(descriptor: UIFontDescriptor(name: "SourceSansPro-Regular", size: 12), size: 12)
        usernameLabel.textColor = .white

        usernameTextField.attributedPlaceholder = NSAttributedString("Username")
        usernameTextField.font = UIFont(descriptor: UIFontDescriptor(name: "SourceSansPro-Regular", size: 20), size: 20)
        usernameTextField.textColor = .white
        usernameTextField.autocorrectionType = .no
        usernameTextField.addTarget(self, action: #selector(textFieldEndedEditing), for: .editingDidEnd)

        nameLabel.text = "NAME"
        nameLabel.font = UIFont(descriptor: UIFontDescriptor(name: "SourceSansPro-Regular", size: 12), size: 12)
        nameLabel.textColor = .white

        nameTextField.attributedPlaceholder = NSAttributedString("Name")
        nameTextField.font = UIFont(descriptor: UIFontDescriptor(name: "SourceSansPro-Regular", size: 20), size: 20)
        nameTextField.textColor = .white
        nameTextField.autocorrectionType = .no
        nameTextField.addTarget(self, action: #selector(textFieldEndedEditing), for: .editingDidEnd)

        button.setTitle("Log out", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(pressedLogoutButton), for: .touchUpInside)
    }

    func defineLayoutForViews() {
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        usernameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }

        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(usernameLabel)
            $0.trailing.equalToSuperview().inset(20)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }

        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(usernameLabel)
            $0.trailing.equalToSuperview().inset(20)
        }

        button.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(45)
        }
    }

}

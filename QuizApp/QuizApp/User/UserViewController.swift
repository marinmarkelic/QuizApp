import Combine
import UIKit
import SnapKit

class UserViewController: UIViewController {

    private var userViewModel: UserViewModel

    private var gradientView: GradientView!

    private var mainView: UIView!

    private var label: UILabel!
    private var textField: UITextField!
    private var button: CustomButton!

    private var cancellables = Set<AnyCancellable>()

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
        bindViewModel()
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
        textField.endEditing(true)
    }

    @objc
    private func textFieldEndedEditing() {
        userViewModel.save(username: textField.text ?? "")
    }

    private func styleTabBarItem() {
        let config = UIImage.SymbolConfiguration(scale: .medium)

        tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape", withConfiguration: config),
            selectedImage: UIImage(systemName: "gearshape.fill", withConfiguration: config))
    }

    private func bindViewModel() {
        userViewModel
            .$userInfo
            .sink { [weak self] userInfo in
                self?.textField.text = userInfo.username
            }.store(in: &cancellables)
    }

}

extension UserViewController: ConstructViewsProtocol {

    func createViews() {
        gradientView = GradientView()
        view.addSubview(gradientView)

        mainView = UIView()
        gradientView.addSubview(mainView)

        label = UILabel()
        mainView.addSubview(label)

        textField = UITextField()
        mainView.addSubview(textField)

        button = CustomButton()
        mainView.addSubview(button)
    }

    func styleViews() {
        label.text = "USERNAME"
        label.font = UIFont(descriptor: UIFontDescriptor(name: "SourceSansPro-Regular", size: 12), size: 12)
        label.textColor = .white

        textField.attributedPlaceholder = NSAttributedString("Username")
        textField.font = UIFont(descriptor: UIFontDescriptor(name: "SourceSansPro-Regular", size: 20), size: 20)
        textField.textColor = .white
        textField.autocorrectionType = .no
        textField.addTarget(self, action: #selector(textFieldEndedEditing), for: .editingDidEnd)

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

        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }

        textField.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(4)
            $0.leading.equalTo(label)
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

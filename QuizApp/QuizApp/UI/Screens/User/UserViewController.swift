import Combine
import UIKit
import SnapKit

class UserViewController: UIViewController {

    private var viewModel: UserViewModel

    private var gradientView: GradientView!

    private var mainView: UIView!

    private var usernameLabel: UILabel!
    private var usernameText: UILabel!

    private var nameLabel: UILabel!
    private var nameTextField: UITextField!

    private var button: CustomButton!

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: UserViewModel) {
        self.viewModel = viewModel

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.getUserInfo()
    }

    @objc
    private func pressedLogoutButton() {
        viewModel.logOut()
    }

    private func addActions() {
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        view.addGestureRecognizer(tapGestureBackground)
    }

    @objc
    private func backgroundTapped(_ sender: UITapGestureRecognizer) {
        nameTextField.endEditing(true)
    }

    @objc
    private func textFieldEndedEditing() {
        viewModel.save(username: usernameText.text ?? "", name: nameTextField.text ?? "")
    }

    private func styleTabBarItem() {
        let config = UIImage.SymbolConfiguration(scale: .medium)

        tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape", withConfiguration: config),
            selectedImage: UIImage(systemName: "gearshape.fill", withConfiguration: config))
    }

    private func bindViewModel() {
        viewModel
            .$userInfo
            .sink { [weak self] userInfo in
                guard let self = self else { return }

                DispatchQueue.main.async {
                    self.usernameText.text = userInfo.username
                    self.nameTextField.text = userInfo.name
                }
            }
            .store(in: &cancellables)
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

        usernameText = UILabel()
        mainView.addSubview(usernameText)

        nameLabel = UILabel()
        mainView.addSubview(nameLabel)

        nameTextField = UITextField()
        mainView.addSubview(nameTextField)

        button = CustomButton()
        mainView.addSubview(button)
    }

    func styleViews() {
        let titleView = UILabel()
        titleView.text = "PopQuiz"
        titleView.textColor = .white
        titleView.font = .heading3
        navigationItem.titleView = titleView

        usernameLabel.text = "USERNAME"
        usernameLabel.font = .body2
        usernameLabel.textColor = .white

        usernameText.font = .heading4
        usernameText.textColor = .white

        nameLabel.text = "NAME"
        nameLabel.font = .body2
        nameLabel.textColor = .white

        nameTextField.attributedPlaceholder = NSAttributedString("Name")
        nameTextField.font = .heading4
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

        usernameText.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(usernameLabel)
            $0.trailing.equalToSuperview().inset(20)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(usernameText.snp.bottom).offset(40)
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

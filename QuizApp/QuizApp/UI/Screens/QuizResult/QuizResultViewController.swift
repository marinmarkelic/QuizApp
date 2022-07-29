import UIKit

class QuizResultViewController: UIViewController {

    private let text: String

    private let viewModel: QuizResultViewModel

    private var gradientView: GradientView!
    private var mainView: UIView!

    private var label: UILabel!
    private var button: UIButton!

    init(text: String, viewModel: QuizResultViewModel) {
        self.text = text
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension QuizResultViewController: ConstructViewsProtocol {

    func createViews() {
        gradientView = GradientView()
        view.addSubview(gradientView)

        mainView = UIView()
        gradientView.addSubview(mainView)

        label = UILabel()
        mainView.addSubview(label)

        button = UIButton()
        mainView.addSubview(button)
    }

    func styleViews() {
        label.font = UIFont(name: "SourceSansPro-Bold", size: 88)
        label.textColor = .white
        label.textAlignment = .center
        label.text = text

        button.setTitle("Finish Quiz", for: .normal)
        button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 16)
        button.setTitleColor(UIColor(red: 99 / 255, green: 41 / 255, blue: 222 / 255, alpha: 1.0), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(exitQuiz), for: .touchUpInside)
    }

    @objc
    private func exitQuiz() {
        viewModel.exitQuiz()
    }

    func defineLayoutForViews() {
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        button.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
    }

}

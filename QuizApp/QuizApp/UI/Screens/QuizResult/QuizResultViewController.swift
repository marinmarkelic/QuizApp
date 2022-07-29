import UIKit

class QuizResultViewController: UIViewController {

    private var viewModel: QuizResultViewModel!

    private var gradientView: GradientView!
    private var mainView: UIView!

    private var label: UILabel!

    init(viewModel: QuizResultViewModel) {
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
    }

    func styleViews() {
        label.font = UIFont(name: "SourceSansPro-Bold", size: 88)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "teest"
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
    }

}

import UIKit

class QuizViewController: UIViewController {

    private var gradientView: GradientView!

    private var mainView: UIView!

    private var titleView: UILabel!

    init() {
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
    }

    func styleTabBarItem() {
        let config = UIImage.SymbolConfiguration(scale: .medium)

        tabBarItem = UITabBarItem(
            title: "Quiz",
            image: UIImage(systemName: "rectangle.3.offgrid", withConfiguration: config),
            selectedImage: UIImage(systemName: "rectangle.3.offgrid.fill", withConfiguration: config))
    }

}

extension QuizViewController: ConstructViewsProtocol {

    func createViews() {
        gradientView = GradientView()
        view.addSubview(gradientView)

        mainView = UIView()
        gradientView.addSubview(mainView)

        titleView = UILabel()
    }

    func styleViews() {
        titleView.text = "PopQuiz"
        titleView.textColor = .white
        titleView.font = UIFont(descriptor: UIFontDescriptor(name: "SourceSansPro-Regular", size: 24), size: 24)
        tabBarController?.navigationItem.titleView = titleView

    }

    func defineLayoutForViews() {
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

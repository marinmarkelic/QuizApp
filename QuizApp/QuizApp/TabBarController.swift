import UIKit

class TabBarController: UITabBarController {

    private var userViewController: UserViewController
    private var quizViewController: QuizViewController

    init(userViewController: UserViewController, quizViewController: QuizViewController) {
        self.userViewController = userViewController
        self.quizViewController = quizViewController

        super.init(nibName: nil, bundle: nil)
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

}

extension TabBarController: ConstructViewsProtocol {

    func createViews() {
        viewControllers = [quizViewController, userViewController]
    }

    func styleViews() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }

    func defineLayoutForViews() {}

}

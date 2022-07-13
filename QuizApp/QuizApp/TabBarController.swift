import UIKit

class TabBarController: UITabBarController {

    private var userViewController: UserViewController

    init(userViewController: UserViewController) {
        self.userViewController = userViewController

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
        viewControllers = [userViewController]
    }

    func styleViews() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }

    func defineLayoutForViews() {}

}

import UIKit

class TabBarController: UITabBarController {

    init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)

        self.viewControllers = viewControllers
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

    func createViews() {}

    func styleViews() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black

        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()

        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: UIFont.body2]
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.font: UIFont.subtitle4]

        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBar.standardAppearance = tabBarAppearance
    }

    func defineLayoutForViews() {}

}

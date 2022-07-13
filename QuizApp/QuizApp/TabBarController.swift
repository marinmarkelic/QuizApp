import UIKit

class TabBarController: UITabBarController, ConstructViewsProtocol {

    private var userViewController: UserViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        userViewController = UserViewController()

        userViewController.tabBarItem = UITabBarItem(title: "Settings", image: nil, selectedImage: nil)

        viewControllers = [userViewController]
    }

    func styleViews() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }

    func defineLayoutForViews() {}

}

extension TabBarController: UITabBarControllerDelegate {

}

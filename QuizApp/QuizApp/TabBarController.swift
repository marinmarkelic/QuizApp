import UIKit

class TabBarController: UITabBarController, ConstructViewsProtocol {

    private var quizViewController: QuizViewController!
    private var searchViewController: SearchViewController!
    private var userViewController: UserViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        quizViewController = QuizViewController()
        quizViewController.tabBarItem = UITabBarItem(title: "Quiz", image: nil, selectedImage: nil)

        searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: nil, selectedImage: nil)

        userViewController = UserViewController()
        userViewController.tabBarItem = UITabBarItem(title: "Settings", image: nil, selectedImage: nil)

        viewControllers = [quizViewController, searchViewController, userViewController]
    }

    func styleViews() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }

    func defineLayoutForViews() {}

}

extension TabBarController: UITabBarControllerDelegate {

}

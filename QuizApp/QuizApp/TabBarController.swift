import UIKit

class TabBarController: UITabBarController {

    private let appRouter: AppRouterProtocol
    private let appDependencies: AppDependencies

    private var quizViewController: QuizViewController!
    private var searchViewController: SearchViewController!
    private var userViewController: UserViewController!

    init(appRouter: AppRouterProtocol, appDependencies: AppDependencies) {
        self.appRouter = appRouter
        self.appDependencies = appDependencies

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
        let config = UIImage.SymbolConfiguration(scale: .medium)

        quizViewController = QuizViewController()
        quizViewController.tabBarItem = UITabBarItem(
            title: "Quiz",
            image: UIImage(systemName: "rectangle.grid.2x2", withConfiguration: config),
            selectedImage: UIImage(systemName: "rectangle.grid.2x2.fill", withConfiguration: config))
        searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass", withConfiguration: config),
            selectedImage: UIImage(systemName: "magnifyingglass", withConfiguration: config))

        userViewController = UserViewController(
            userViewModel: UserViewModel(appRouter: appRouter, userUseCase: appDependencies.userUseCase))
        userViewController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape", withConfiguration: config),
            selectedImage: UIImage(systemName: "gearshape.fill", withConfiguration: config))

        viewControllers = [quizViewController, searchViewController, userViewController]
    }

    func styleViews() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }

    func defineLayoutForViews() {}

}

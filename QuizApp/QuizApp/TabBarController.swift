import UIKit

class TabBarController: UITabBarController, ConstructViewsProtocol {

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

    func createViews() {
        quizViewController = QuizViewController()
        quizViewController.tabBarItem = UITabBarItem(title: "Quiz", image: nil, selectedImage: nil)

        searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: nil, selectedImage: nil)

        userViewController = UserViewController(
            userViewModel: UserViewModel(appRouter: appRouter, userUseCase: appDependencies.userUseCase))
        userViewController.tabBarItem = UITabBarItem(title: "Settings", image: nil, selectedImage: nil)

        viewControllers = [quizViewController, searchViewController, userViewController]
    }

    func styleViews() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }

    func defineLayoutForViews() {}

}

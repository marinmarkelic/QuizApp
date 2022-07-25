import UIKit
import Resolver

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController
    private let container: Resolver

    private var quizNavigationController: UINavigationController!
    private var userNavigationController: UINavigationController!

    init(container: Resolver) {
        self.container = container
        navigationController = UINavigationController()

        quizNavigationController = UINavigationController()
        userNavigationController = UINavigationController()
    }

    func start(in window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        showInitialViewController()
    }

    func showLogin() {
        let loginViewController = container.resolve(LoginViewController.self)
        navigationController.setViewControllers([loginViewController], animated: true)
    }

    func showHome() {
        let quizViewController = container.resolve(QuizViewController.self)
        quizNavigationController.viewControllers = [quizViewController]

        let userViewController = container.resolve(UserViewController.self)
        userNavigationController.viewControllers = [userViewController]

        let viewControllers = [quizNavigationController!, userNavigationController!]

        let tabBarController = TabBarController(viewControllers: viewControllers)
        tabBarController.navigationController?.navigationBar.isHidden = true

        navigationController.setViewControllers([tabBarController], animated: true)
    }

    func showQuizDetails(with quiz: Quiz) {
        let quizDetailsViewController = container.resolve(QuizDetailsViewController.self)
        quizDetailsViewController.set(quiz: quiz)

        quizNavigationController.pushViewController(quizDetailsViewController, animated: true)
    }

    private func showInitialViewController() {
        Task {
            do {
                let userNetworkDataSource = container.resolve(UserNetworkDataSourceProtocol.self)
                try await userNetworkDataSource.check()

                DispatchQueue.main.async { [weak self] in
                    self?.showHome()
                }
            } catch {
                container.resolve(SecureStorageProtocol.self).deleteAccessToken()

                DispatchQueue.main.async { [weak self] in
                    self?.showLogin()
                }
            }
        }
    }

}

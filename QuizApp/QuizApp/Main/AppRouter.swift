import UIKit
import Resolver

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController
    private let container: Resolver

    init(container: Resolver) {
        self.container = container
        navigationController = UINavigationController()
    }

    func start(in window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        showInitialViewController()
    }

    func showLogin() {
        let loginViewController = LoginViewController(loginViewModel: container.resolve())
        navigationController.setViewControllers([loginViewController], animated: true)
    }

    func showHome() {
        let quizViewController = QuizViewController(quizViewModel: container.resolve())
        let userViewController = UserViewController(userViewModel: container.resolve())

        let viewControllers = [quizViewController, userViewController]

        let tabBarController = TabBarController(viewControllers: viewControllers)

        navigationController.setViewControllers([tabBarController], animated: true)
    }

    private func showInitialViewController() {
        Task {
            do {
                let userNetworkDataSource: UserNetworkDataSourceProtocol = container.resolve()
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

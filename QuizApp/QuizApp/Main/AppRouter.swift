import UIKit
import Resolver

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController
    private let resolver: Resolver

    init(resolver: Resolver) {
        self.navigationController = UINavigationController()
        self.resolver = resolver
    }

    func start(in window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        showInitialViewController()
    }

    func showLogin() {
        let loginViewController = LoginViewController(
            viewModel: LoginViewModel(loginUseCase: resolver.resolve(), appRouter: self))
        navigationController.setViewControllers([loginViewController], animated: true)
    }

    func showHome() {
        let quizViewController = QuizViewController(quizUseCase: resolver.resolve())
        let userViewController = UserViewController(
            appRouter: self,
            userUseCase: resolver.resolve(),
            logoutUseCase: resolver.resolve())

        let viewControllers = [quizViewController, userViewController]

        let tabBarController = TabBarController(viewControllers: viewControllers)

        navigationController.setViewControllers([tabBarController], animated: true)
    }

    private func showInitialViewController() {
        Task {
            do {
                let userNetworkDataSource: UserNetworkDataSourceProtocol = resolver.resolve()
                try await userNetworkDataSource.check()

                DispatchQueue.main.async { [weak self] in
                    self?.showHome()
                }
            } catch {
                resolver.resolve(SecureStorageProtocol.self).deleteAccessToken()

                DispatchQueue.main.async { [weak self] in
                    self?.showLogin()
                }
            }
        }
    }

}

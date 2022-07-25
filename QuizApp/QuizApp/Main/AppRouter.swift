import UIKit
import Resolver

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController
    private let resolver: Resolver

    init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
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

}

import UIKit
import Resolver

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController
    private let dependencies: Resolver

    init(navigationController: UINavigationController, dependencies: Resolver) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func showLogin() {
        let loginViewController = LoginViewController(
            viewModel: LoginViewModel(loginUseCase: Resolver.resolve(), appRouter: self))
        navigationController.setViewControllers([loginViewController], animated: true)
    }

    func showHome() {
        let quizViewController = QuizViewController(quizUseCase: Resolver.resolve())
        let userViewController = UserViewController(
            appRouter: self,
            userUseCase: Resolver.resolve(),
            logoutUseCase: Resolver.resolve())

        let viewControllers = [quizViewController, userViewController]

        let tabBarController = TabBarController(viewControllers: viewControllers)

        navigationController.setViewControllers([tabBarController], animated: true)
    }

}

import UIKit
import Resolver

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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

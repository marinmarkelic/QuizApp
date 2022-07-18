import UIKit

class AppRouter: AppRouterProtocol {

    private let appDependencies: AppDependencies
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController, appDependencies: AppDependencies) {
        self.navigationController = navigationController
        self.appDependencies = appDependencies
    }

    func showLogin() {
        let loginViewController = LoginViewController(
            viewModel: LoginViewModel(loginUseCase: appDependencies.loginUseCase, appRouter: self))
        navigationController.setViewControllers([loginViewController], animated: true)
    }

    func showHome() {
        let quizViewController = QuizViewController(quizUseCase: appDependencies.quizUseCase)
        let userViewController = UserViewController(
            appRouter: self,
            userUseCase: appDependencies.userUseCase,
            logoutUseCase: appDependencies.logoutUseCase)

        let viewControllers = [quizViewController, userViewController]

        let tabBarController = TabBarController(viewControllers: viewControllers)

        navigationController.setViewControllers([tabBarController], animated: true)
    }

}

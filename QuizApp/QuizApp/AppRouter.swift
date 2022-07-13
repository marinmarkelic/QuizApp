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
        navigationController.pushViewController(loginViewController, animated: true)
    }

    func showUser() {
        let userViewController = UserViewController()

        if navigationController.viewControllers.isEmpty {
            navigationController.pushViewController(userViewController, animated: true)
        } else {
            navigationController.setViewControllers([userViewController], animated: true)
        }
    }

}

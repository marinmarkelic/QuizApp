import UIKit

class AppRouter: AppRouterProtocol {

    private let appDependencies: AppDependencies
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController, appDependencies: AppDependencies) {
        self.navigationController = navigationController
        self.appDependencies = appDependencies
    }

    func showLoginViewController() {
        let loginViewController = LoginViewController(
            viewModel: LoginViewModel(loginUseCase: appDependencies.loginUseCase, appRouter: self))
        navigationController.setViewControllers([loginViewController], animated: true)
    }

    func showUserViewController() {
        let userViewController = UserViewController()
        navigationController.setViewControllers([userViewController], animated: true)
    }

}

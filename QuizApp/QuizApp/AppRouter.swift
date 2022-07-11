import UIKit

class AppRouter: AppRouterProtocol {

    private let appDependencies = AppDependencies()
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showLogin() {
        let loginViewController = LoginViewController(
            viewModel: LoginViewModel(loginClient: appDependencies.loginClient))
        navigationController.pushViewController(loginViewController, animated: true)
    }

}

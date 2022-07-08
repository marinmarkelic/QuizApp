import UIKit

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showLogin() {
        let loginViewController = LoginViewController(viewModel: LoginViewModel())
        navigationController.pushViewController(loginViewController, animated: true)
    }

}

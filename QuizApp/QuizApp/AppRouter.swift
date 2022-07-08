import UIKit

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showLogin() {
        let loginVC = LoginViewController(viewModel: LoginViewModel())
        navigationController.pushViewController(loginVC, animated: false)
    }

}

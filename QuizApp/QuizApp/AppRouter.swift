import UIKit

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showLogin(in window: UIWindow?) {
        let loginVC = LoginViewController(viewModel: LoginViewModel())

        navigationController.pushViewController(loginVC, animated: false)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}

import UIKit

class AppRouter: AppRouterProtocol {

    private let appDependencies = AppDependencies()
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func setStartController() {
        if appDependencies.secureStorage.accessToken != nil {
            showUser()
        } else {
            showLogin()
        }
    }

    private func showLogin() {
        let loginViewController = LoginViewController(
            viewModel: LoginViewModel(loginUseCase: appDependencies.loginUseCase))
        navigationController.pushViewController(loginViewController, animated: true)
    }

    private func showUser() {
        let userViewControlleer = UserViewController()
        navigationController.pushViewController(userViewControlleer, animated: true)
    }

}

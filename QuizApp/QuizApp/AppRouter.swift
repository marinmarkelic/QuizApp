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
        let userViewControlleer = UserViewController()

        print(navigationController.viewControllers)

        if navigationController.viewControllers.isEmpty {
            navigationController.pushViewController(userViewControlleer, animated: true)
        } else {
            navigationController.dismiss(animated: false)
            navigationController.popViewController(animated: false)
            print(navigationController.viewControllers)

            navigationController.pushViewController(userViewControlleer, animated: true)
            print(navigationController.viewControllers)
        }
    }

}

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let appDependencies = AppDependencies()
    private var appRouter: AppRouterProtocol!

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        appRouter = AppRouter(navigationController: navigationController, appDependencies: appDependencies)

        showInitialViewController()

        self.window = window
        return true
    }

    private func showInitialViewController() {
        Task {
            do {
                try await appDependencies.userNetworkDataSource.check()

                DispatchQueue.main.async { [weak self] in
                    self?.appRouter.showUser()
                }
            } catch {
                appDependencies.secureStorage.deleteAccessToken()

                DispatchQueue.main.async { [weak self] in
                    self?.appRouter.showLogin()
                }
            }
        }
    }

}

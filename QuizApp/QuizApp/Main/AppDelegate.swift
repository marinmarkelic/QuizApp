import UIKit
import Resolver

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appRouter: AppRouterProtocol!
    private var dependencies: Resolver!

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()

        dependencies = Resolver.dependencies

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        appRouter = AppRouter(navigationController: navigationController, dependencies: dependencies)

        showInitialViewController()

        self.window = window
        return true
    }

    private func showInitialViewController() {
        Task {
            do {
                let userNetworkDataSource: UserNetworkDataSourceProtocol = Resolver.resolve()
                try await userNetworkDataSource.check()

                DispatchQueue.main.async { [weak self] in
                    self?.appRouter.showHome()
                }
            } catch {
                Resolver.resolve(SecureStorageProtocol.self).deleteAccessToken()

                DispatchQueue.main.async { [weak self] in
                    self?.appRouter.showLogin()
                }
            }
        }
    }

}

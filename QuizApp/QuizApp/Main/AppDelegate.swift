import UIKit
import Resolver

@main
class AppDelegresolveate: UIResponder, UIApplicationDelegate {

    private var appRouter: AppRouterProtocol!
    private var appDependencies: AppDependencies!
    private var resolver: Resolver!

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()

        appDependencies = AppDependencies()

        resolver = appDependencies.container

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        appRouter = AppRouter(navigationController: navigationController, resolver: resolver)

        showInitialViewController()

        self.window = window
        return true
    }

    private func showInitialViewController() {
        Task {
            do {
                let userNetworkDataSource: UserNetworkDataSourceProtocol = resolver.resolve()
                try await userNetworkDataSource.check()

                DispatchQueue.main.async { [weak self] in
                    self?.appRouter.showHome()
                }
            } catch {
                resolver.resolve(SecureStorageProtocol.self).deleteAccessToken()

                DispatchQueue.main.async { [weak self] in
                    self?.appRouter.showLogin()
                }
            }
        }
    }

}

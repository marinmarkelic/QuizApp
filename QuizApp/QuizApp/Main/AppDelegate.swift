import UIKit
import Resolver

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

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

        appRouter = AppRouter(navigationController: navigationController)

        showInitialViewController()

        self.window = window
        return true
    }

    private func showInitialViewController() {
        Task {
            do {
                try await Resolver.resolve(UserNetworkDataSourceProtocol.self).check()

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

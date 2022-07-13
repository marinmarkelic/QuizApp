import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appRouter: AppRouterProtocol!

    private let appDependencies = AppDependencies()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        appRouter = AppRouter(navigationController: navigationController, appDependencies: appDependencies)

        setViewController()

        self.window = window
        return true
    }

    private func setViewController() {
        Task {
            do {
                try await appDependencies.userNetworkDataSource.check()

                DispatchQueue.main.async { [weak self] in
                    self?.appRouter.showUser()
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.appRouter.showLogin()
                }
            }
        }
    }

}

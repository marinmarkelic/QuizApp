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

        self.window = window
        return true
    }

}

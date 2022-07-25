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

        appDependencies = AppDependencies()

        appRouter = appDependencies.appRouter
        appRouter.start(in: window)

        self.window = window
        return true
    }

}

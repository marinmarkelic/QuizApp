import UIKit
import Resolver
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var router: AppRouterProtocol!
    private var appDependencies: AppDependencies!

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)

        appDependencies = AppDependencies()

//        router = appDependencies.appRouter
//        router.start(in: window)

        window.rootViewController = UIHostingController(rootView: ContentView(container: appDependencies.container))
        window.makeKeyAndVisible()

        self.window = window
        return true
    }

}

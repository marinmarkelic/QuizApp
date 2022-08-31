import UIKit
import Resolver
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appDependencies: AppDependencies!
    private var appData: AppData!

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)

        appDependencies = AppDependencies()
        appData = AppData()

//        let viewController = UIHostingController(
//            rootView:
//                ContentView()
//                .environmentObject(appDependencies.container)
//                .environmentObject(appData))

        let viewController = UIHostingController(rootView: CircularLoadingView())

        window.rootViewController = viewController
        window.makeKeyAndVisible()

        self.window = window
        return true
    }

}

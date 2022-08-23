import UIKit
import Resolver
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appDependencies: AppDependencies!
    private var container: Resolver!

    private var initialView: some View {
        get async {
            do {
                let userNetworkDataSource = container.resolve(UserNetworkDataSourceProtocol.self)
                try await userNetworkDataSource.check()

                return AnyView(TabBarView(
                    quizViewModel: container.resolve(),
                    searchViewModel: container.resolve(),
                    userViewModel: container.resolve()))
            } catch {
                container.resolve(SecureStorageProtocol.self).deleteAccessToken()
                return AnyView(LoginView(viewModel: container.resolve()))
            }
        }
    }

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)

        appDependencies = AppDependencies()
        container = appDependencies.container

        Task {
            let viewController = await UIHostingController(rootView: initialView)
            window.rootViewController = viewController
            window.makeKeyAndVisible()
        }
        self.window = window
        return true
    }

}

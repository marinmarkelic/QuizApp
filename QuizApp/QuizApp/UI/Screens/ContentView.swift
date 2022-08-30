import SwiftUI
import Resolver
import UIPilot

struct ContentView: View {

    @EnvironmentObject var container: Resolver
    @EnvironmentObject var appData: AppData

    var body: some View {
        Group {
            switch appData.loginStatus {
            case .loggedIn:
                TabBarView()
            case .notLoggedIn:
                LoginView(viewModel: container.resolve())
            case .unknown:
                Text("Checking access token")
                    .onAppear {
                        checkLoginStatus()
                    }
            }
        }
        .environmentObject(container)
        .environmentObject(appData)
    }

    private func checkLoginStatus() {
        Task {
            do {
                let userNetworkDataSource = container.resolve(UserNetworkDataSourceProtocol.self)
                try await userNetworkDataSource.check()

                appData.loginStatus = .loggedIn
            } catch {
                container.resolve(SecureStorageProtocol.self).deleteAccessToken()
                appData.loginStatus = .notLoggedIn
            }
        }
    }

}

class AppData: ObservableObject {

    @Published var loginStatus: LoginStatus = .unknown
    @Published var selectedTab: AppRoute = .quizzes

}

enum LoginStatus {

    case unknown
    case notLoggedIn
    case loggedIn

}

import SwiftUI
import Resolver
import UIPilot

struct ContentView: View {

    var container: Resolver

    @ObservedObject var shared = Shared()

    var body: some View {
        Group {
            switch shared.loginStatus {
            case .loggedIn:
                TabBarView()
            case .notLoggedIn:
                LoginView(viewModel: container.resolve())
            case .unknown:
                Text("")
            }
        }
        .onAppear {
            checkLoginStatus()
        }
        .environmentObject(container)
        .environmentObject(shared)
    }

    private func checkLoginStatus() {
        Task {
            do {
                let userNetworkDataSource = container.resolve(UserNetworkDataSourceProtocol.self)
                try await userNetworkDataSource.check()

                shared.loginStatus = .loggedIn
            } catch {
                container.resolve(SecureStorageProtocol.self).deleteAccessToken()
                shared.loginStatus = .notLoggedIn
            }
        }
    }

}

class Shared: ObservableObject {

    @Published var loginStatus: LoginStatus = .unknown
    @Published var selectedTab: AppRoute = .quizzes

}

enum LoginStatus {

    case unknown
    case notLoggedIn
    case loggedIn

}

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
                CircularLoadingView()
                    .onAppear {
                        checkLoginStatus()
                    }
            }
        }
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

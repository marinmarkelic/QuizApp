import SwiftUI
import Resolver

struct ContentView: View {

    var container: Resolver

    @ObservedObject var loginCheck = LoginCheck()

    var body: some View {
        Group {
            switch loginCheck.isLoggedIn {
            case true:
                TabBarView()
            case false:
                LoginView(viewModel: container.resolve())
            default:
                Text("")
                    .task {
                        do {
                            let userNetworkDataSource = container.resolve(UserNetworkDataSourceProtocol.self)
                            try await userNetworkDataSource.check()

                            loginCheck.isLoggedIn = true
                        } catch {
                            container.resolve(SecureStorageProtocol.self).deleteAccessToken()
                            loginCheck.isLoggedIn = false
                        }
                    }
            }
        }
        .environmentObject(container)
        .environmentObject(loginCheck)
    }

}

class LoginCheck: ObservableObject {

    @Published var isLoggedIn: Bool?

}

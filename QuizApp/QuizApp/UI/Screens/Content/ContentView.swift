import SwiftUI
import Resolver
import UIPilot

struct ContentView: View {

    @EnvironmentObject var container: Resolver
    @EnvironmentObject var appData: AppData

    @ObservedObject var viewModel: ContentViewModel

    var body: some View {
        Group {
            switch appData.loginStatus {
            case .loggedIn:
                TabBarView()
            case .loggedOut:
                LoginView(viewModel: container.resolve())
            case .unknown:
                Text("Checking access token")
                    .onAppear { viewModel.checkLoginStatus(appData: appData) }
            }
        }
    }

}

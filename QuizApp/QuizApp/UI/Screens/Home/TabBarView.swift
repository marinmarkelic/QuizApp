import SwiftUI
import Resolver

struct TabBarView: View {

    @EnvironmentObject var container: Resolver

    var body: some View {
        TabView {
            QuizView(viewModel: container.resolve())
                .tabItem {
                    Label("Quiz", systemImage: "gearshape")
                }

            SearchView(viewModel: container.resolve())
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            SettingsView(viewModel: container.resolve())
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = .white
            UITabBar.appearance().barTintColor = .gray
        }
    }

}

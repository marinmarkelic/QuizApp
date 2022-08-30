import SwiftUI
import Resolver

struct TabBarView: View {

    @EnvironmentObject var container: Resolver
    @EnvironmentObject var shared: Shared

    @State var selectedTab: AppRoute = .quizzes

    var body: some View {
        TabView(selection: $shared.selectedTab) {
            QuizSelectionView()
                .tabItem {
                    Label("Quiz", systemImage: "gearshape")
                }
                .tag(AppRoute.quizzes)

            SearchSelectionView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(AppRoute.search)

            SettingsView(viewModel: container.resolve())
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(AppRoute.settings)
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = .white
            UITabBar.appearance().barTintColor = .gray
        }
    }

}

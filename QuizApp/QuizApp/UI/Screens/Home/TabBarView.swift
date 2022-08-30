import SwiftUI
import Resolver

struct TabBarView: View {

    @EnvironmentObject var container: Resolver
    @EnvironmentObject var appData: AppData

    var body: some View {
        TabView(selection: $appData.selectedTab) {
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

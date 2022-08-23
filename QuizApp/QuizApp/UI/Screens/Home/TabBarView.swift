import SwiftUI

struct TabBarView: View {

    let quizViewModel: QuizViewModel
    let searchViewModel: SearchViewModel
    let userViewModel: UserViewModel

    var body: some View {
        TabView {
            QuizView(viewModel: quizViewModel)
                .tabItem {
                    Label("Quiz", systemImage: "gearshape")
                }

            SearchView(viewModel: searchViewModel)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            SettingsView(viewModel: userViewModel)
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

struct TabBarViewPreview: PreviewProvider {

    static var previews: some View {
        TabBarView(
            quizViewModel: QuizViewModel(),
            searchViewModel: SearchViewModel(),
            userViewModel: UserViewModel())
    }

}

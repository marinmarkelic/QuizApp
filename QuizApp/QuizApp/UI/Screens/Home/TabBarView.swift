import SwiftUI
import Resolver

struct TabBarView: View {

    @EnvironmentObject var container: Resolver

    var body: some View {
//        ResolverView { container in
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
//        }
    }

}

struct TabBarViewPreview: PreviewProvider {

    static var previews: some View {
        TabBarView()
    }

}

struct ResolverView<Destination: View>: View {

    let content: (Resolver) -> Destination

    @EnvironmentObject var container: Resolver

    init(content: @escaping (Resolver) -> Destination) {
        self.content = content
    }

    var body: some View {
        content(container)
    }

}

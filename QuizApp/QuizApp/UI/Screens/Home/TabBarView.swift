import SwiftUI

struct TabBarView: View {

    var body: some View {
        TabView {
            QuizView(viewModel: QuizViewModel())

            SearchView(viewModel: SearchViewModel())

            SettingsView(viewModel: UserViewModel())
        }
    }

}

struct TabBarViewPreview: PreviewProvider {

    static var previews: some View {
        TabBarView()
    }

}

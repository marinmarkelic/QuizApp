import SwiftUI
import SDWebImageSwiftUI

struct SearchView: View {

    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        VStack {
            content
                .padding()
        }
        .maxWidth()
        .background(LinearGradient.background.ignoresSafeArea())
    }

    private var content: some View {
        VStack {
            SearchBar(text: $viewModel.searchText)
                .onSearchTap {
                    viewModel.fetchQuizzes()
                }

            QuizListView(quizzes: viewModel.quizzes)
                .onQuizTap { quiz in
                }
        }
    }

}

struct SearchPreview: PreviewProvider {

    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }

}

import SwiftUI
import SDWebImageSwiftUI

struct SearchView: View {

    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                    .onSearchTap {
                        viewModel.fetchQuizzes()
                    }

                QuizListView(quizzes: viewModel.quizzes)
            }
            .maxWidth()
            .padding()
            .background(LinearGradient.background.ignoresSafeArea())
            .navigationBarTitle("PopQuiz")
        }
    }

}

struct SearchPreview: PreviewProvider {

    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }

}

import SwiftUI
import SDWebImageSwiftUI

struct SearchView: View {

    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
            VStack {
                SearchBar(text: $viewModel.searchText)
                    .onSearchTap {
                        viewModel.fetchQuizzes()
                    }

                QuizListView(quizzes: viewModel.quizzes, errorMessage: viewModel.errorMessage)
            }
            .maxWidth()
            .padding()
            .background(LinearGradient.background.ignoresSafeArea())
            .navigationBarTitle("PopQuiz")
            .navigationBarBackButtonHidden(true)
        }

}

struct SearchPreview: PreviewProvider {

    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }

}

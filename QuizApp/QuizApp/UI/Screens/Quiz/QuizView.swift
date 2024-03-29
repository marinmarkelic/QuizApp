import SwiftUI
import Resolver

struct QuizView: View {

    @ObservedObject var viewModel: QuizViewModel

    var body: some View {
        VStack {
            CategorySlider(categories: viewModel.categories)
                .onCategoryTap {
                    viewModel.changeCategory(for: $0.type)
                }

            QuizListView(
                quizzes: viewModel.quizzes,
                errorMessage: viewModel.errorMessage,
                alwaysShowSections: false)
        }
        .maxWidth()
        .maxHeight()
        .padding()
        .background(LinearGradient.background.ignoresSafeArea())
        .onAppear {
            viewModel.loadCategories()
        }
        .navigationBarTitle("PopQuiz")
        .navigationBarBackButtonHidden(true)
    }

}

struct QuizViewPreview: PreviewProvider {

    static var previews: some View {
        QuizView(viewModel: QuizViewModel())
    }

}

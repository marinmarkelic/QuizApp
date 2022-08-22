import SwiftUI

struct QuizView: View {

    @ObservedObject var viewModel: QuizViewModel

    var body: some View {
        VStack {
            CategorySlider(categories: viewModel.categories)
                .onCategoryTap {
                    viewModel.changeCategory(for: $0.type)
                }
                .onAppear {
                    viewModel.loadCategories()
                }

            QuizListView(quizzes: viewModel.quizzes, alwaysShowSections: false)
                .onQuizTap {
                    viewModel.showQuizDetails(with: $0)
                }
        }
        .maxWidth()
        .maxHeight()
        .padding()
        .background(LinearGradient.background.ignoresSafeArea())
    }

}

struct QuizViewPreview: PreviewProvider {

    static var previews: some View {
        QuizView(viewModel: QuizViewModel())
    }

}

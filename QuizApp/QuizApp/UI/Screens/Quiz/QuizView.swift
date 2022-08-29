import SwiftUI
import Resolver

struct QuizView: View {

    @ObservedObject var viewModel: QuizViewModel

    var body: some View {
        NavigationView {
            VStack {
                CategorySlider(categories: viewModel.categories)
                    .onCategoryTap {
                        viewModel.changeCategory(for: $0.type)
                    }

                QuizListView(quizzes: viewModel.quizzes, alwaysShowSections: false)
            }
            .maxWidth()
            .maxHeight()
            .padding()
            .background(LinearGradient.background.ignoresSafeArea())
            .onAppear {
                viewModel.loadCategories()
            }
            .navigationBarTitle("PopQuiz", displayMode: .inline)
        }
    }

}

struct QuizViewPreview: PreviewProvider {

    static var previews: some View {
        QuizView(viewModel: QuizViewModel())
    }

}

class QuizStates: ObservableObject {

    @Published var didSelectQuiz: Bool = false
    @Published var selectedQuiz: Quiz?

    func reset() {
        didSelectQuiz = false
        selectedQuiz = nil
    }

}

import SwiftUI
import Resolver
import LazyViewSwiftUI

struct SolvingQuizView: View {

    @EnvironmentObject var container: Resolver

    @ObservedObject var viewModel: SolvingQuizViewModel

    var body: some View {
        VStack(spacing: 50) {
            ProgressView(
                progressText: viewModel.progressText,
                progressData: viewModel.progressData)

            QuestionView(quiz: viewModel.quiz, currentQuestionIndex: viewModel.currentQuestionIndex)
                .onAnswerTap {
                    viewModel.selectedAnswer(with: $0)
                }
                .animation(.spring(), value: viewModel.currentQuestionIndex)

            NavigationLink("", isActive: $viewModel.isFinished) {
                LazyView(QuizResultView(viewModel: container.resolve(QuizResultViewModel.self, args: viewModel.result)))
            }
        }
        .maxSize()
        .padding()
        .background(LinearGradient.background.ignoresSafeArea())
        .navigationBarTitle("PopQuiz", displayMode: .inline)
    }

}

struct SolvingQuizPreview: PreviewProvider {

    static var previews: some View {
        SolvingQuizView(viewModel: SolvingQuizViewModel())
    }

}

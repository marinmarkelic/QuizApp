import SwiftUI

struct SolvingQuizView: View {

    @ObservedObject var viewModel: SolvingQuizViewModel

    var body: some View {
        VStack(spacing: 50) {
            ProgressView(progressText: viewModel.progressText, progressColors: viewModel.progressColors)

            QuestionView(quiz: viewModel.quiz, currentQuestionIndex: viewModel.currentQuestionIndex)
                .onAnswerTap {
                    viewModel.selectedAnswer(with: $0)
                }
                .animation(.spring(), value: viewModel.currentQuestionIndex)
        }
        .maxSize()
        .padding()
        .background(LinearGradient.background.ignoresSafeArea())
    }

}

struct SolvingQuizPreview: PreviewProvider {

    static var previews: some View {
        SolvingQuizView(viewModel: SolvingQuizViewModel())
    }

}

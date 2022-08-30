import SwiftUI
import Resolver
import UIPilot

struct SolvingQuizView: View {

    @EnvironmentObject var quizzesPilot: UIPilot<QuizAppRoute>
    @EnvironmentObject var searchPilot: UIPilot<SearchAppRoute>
    @EnvironmentObject var appData: AppData

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

        }
        .maxSize()
        .padding()
        .background(LinearGradient.background.ignoresSafeArea())
        .navigationBarTitle("PopQuiz")
        .onChange(of: viewModel.result) { result in
            if appData.selectedTab == .quizzes {
                quizzesPilot.push(.finished(result))
            } else if appData.selectedTab == .search {
                searchPilot.push(.finished(result))
            }
        }
    }

}

struct SolvingQuizPreview: PreviewProvider {

    static var previews: some View {
        SolvingQuizView(viewModel: SolvingQuizViewModel())
    }

}

import SwiftUI
import Resolver
import UIPilot

struct QuizDetailsView: View {

    @EnvironmentObject var container: Resolver
    @EnvironmentObject var quizzesPilot: UIPilot<QuizAppRoute>
    @EnvironmentObject var searchPilot: UIPilot<SearchAppRoute>
    @EnvironmentObject var appData: AppData

    @ObservedObject var viewModel: QuizDetailsViewModel

    var body: some View {
        CenteredScrollView {
            VStack {
                Text("Leaderboard")
                    .font(.heading5)
                    .foregroundColor(.white)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .frame(maxHeight: 2)
                            .foregroundColor(.white)
                            .cornerRadius(2)
                            .offset(x: 0, y: 2)
                    }
                    .pushedRight()
                    .onTapGesture {
                        if appData.selectedTab == .quizzes {
                            quizzesPilot.push(.leaderboard(viewModel.quiz.id))
                        } else if appData.selectedTab == .search {
                            searchPilot.push(.leaderboard(viewModel.quiz.id))
                        }
                    }

                DetailsView(quiz: viewModel.quiz)
            }
            .padding(.horizontal)
        }
        .background(LinearGradient.background.ignoresSafeArea())
    }

}

struct QuizDetailsPreview: PreviewProvider {

    static var previews: some View {
        QuizDetailsView(viewModel: QuizDetailsViewModel())
    }

}

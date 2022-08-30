import SwiftUI
import UIPilot

struct QuizResultView: View {

    @EnvironmentObject var states: QuizStates

    @ObservedObject var viewModel: QuizResultViewModel
    @EnvironmentObject var quizzesPilot: UIPilot<QuizAppRoute>
    @EnvironmentObject var searchPilot: UIPilot<SearchAppRoute>
    @EnvironmentObject var shared: Shared

    var body: some View {
        VStack {
            Spacer()

            Text(viewModel.text)
                .font(.score)
                .foregroundColor(.white)

            Spacer()

            Button(action: {
                if shared.selectedTab == .quizzes {
                    quizzesPilot.push(.all)
                } else if shared.selectedTab == .search {
                    searchPilot.push(.search)
                }
            }, label: {
                Text("Finish Quiz")
                    .foregroundColor(.purpleText)
                    .font(.heading6)
                    .maxWidth()
            })
            .padding()
            .maxWidth()
            .background(.white)
            .cornerRadius(25)
        }
        .maxSize()
        .padding()
        .background(LinearGradient.background.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }

}

struct QuizResultViewPreview: PreviewProvider {

    static var previews: some View {
        QuizResultView(viewModel: QuizResultViewModel())
    }

}

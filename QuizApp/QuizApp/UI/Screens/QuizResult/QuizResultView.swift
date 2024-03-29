import SwiftUI
import UIPilot

struct QuizResultView: View {

    @ObservedObject var viewModel: QuizResultViewModel
    @EnvironmentObject var quizzesPilot: UIPilot<QuizAppRoute>
    @EnvironmentObject var searchPilot: UIPilot<SearchAppRoute>
    @EnvironmentObject var appData: AppData

    var body: some View {
        VStack {
            Spacer()

            Text(viewModel.text)
                .font(.score)
                .foregroundColor(.white)

            Spacer()

            Button(action: {
                if appData.selectedTab == .quizzes {
                    quizzesPilot.push(.all)
                } else if appData.selectedTab == .search {
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

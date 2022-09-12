import SwiftUI
import UIPilot

struct QuizResultView: View {

    @ObservedObject var viewModel: QuizResultViewModel
    @EnvironmentObject var quizzesPilot: UIPilot<QuizAppRoute>
    @EnvironmentObject var searchPilot: UIPilot<SearchAppRoute>
    @EnvironmentObject var appData: AppData

    @State private var score: Int = 0

    var body: some View {
        VStack {
            Spacer()

            Color.clear
                .modifier(NumberView(number: score, postfix: viewModel.text))
                .onAppear {
                    withAnimation {
                        score = viewModel.score
                    }
                }

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
        .onAppear {
        }
    }

}

struct QuizResultViewPreview: PreviewProvider {

    static var previews: some View {
        QuizResultView(viewModel: QuizResultViewModel())
    }

}

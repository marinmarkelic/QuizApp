import SwiftUI
import UIPilot

struct QuizResultView: View {

    @ObservedObject var viewModel: QuizResultViewModel
    @EnvironmentObject var quizzesPilot: UIPilot<QuizAppRoute>
    @EnvironmentObject var searchPilot: UIPilot<SearchAppRoute>
    @EnvironmentObject var appData: AppData

    @State private var score: Double = 0

    var body: some View {
        VStack {
            Spacer()

            Color.clear
                .modifier(AnimatableNumberModifier(number: score, postfix: viewModel.text))
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

struct AnimatableNumberModifier: AnimatableModifier {

    var number: Double
    var postfix: String = ""

    var animatableData: Double {
        get { number }
        set { number = newValue }
    }

    func body(content: Content) -> some View {
        content
            .overlay(
                Text("\(Int(number))\(postfix)")
                    .font(.score)
                    .foregroundColor(.white)
            )
    }

}

struct QuizResultViewPreview: PreviewProvider {

    static var previews: some View {
        QuizResultView(viewModel: QuizResultViewModel())
    }

}

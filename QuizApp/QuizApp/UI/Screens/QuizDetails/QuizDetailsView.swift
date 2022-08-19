import SwiftUI

struct QuizDetailsView: View {

    @ObservedObject var viewModel: QuizDetailsViewModel

    var body: some View {
        VScrollView {
            VStack(alignment: .trailing) {
                Text("Leaderboard")
                    .font(.heading5)
                    .foregroundColor(.white)
                    .onTapGesture {
                        viewModel.showLeaderboard()
                    }
                    .overlay(
                        Rectangle()
                            .offset(x: 0, y: 2)
                            .frame(maxHeight: 2)
                            .background(.white)
                            .cornerRadius(2),
                        alignment: .bottom)

                DetailsView(quiz: viewModel.quiz)
                    .onStartQuizTap {
                        viewModel.startQuiz()
                    }
            }
            .padding()
        }
        .background(LinearGradient.background.ignoresSafeArea())
    }

}

struct QuizDetailsPreview: PreviewProvider {

    static var previews: some View {
        QuizDetailsView(viewModel: QuizDetailsViewModel())
    }

}

import SwiftUI

struct QuizDetailsView: View {

    @ObservedObject var viewModel: QuizDetailsViewModel

    var body: some View {
        CenteredScrollView {
            VStack {
                    Text("Leaderboard")
                        .font(.heading5)
                        .foregroundColor(.white)
                        .onTapGesture {
                        }
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .frame(maxHeight: 2)
                                .foregroundColor(.white)
                                .cornerRadius(2)
                                .offset(x: 0, y: 2)
                        }
                        .pushedRight()

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

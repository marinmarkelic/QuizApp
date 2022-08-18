import SwiftUI

struct QuizDetailsView: View {

    @ObservedObject var viewModel: QuizDetailsViewModel

    var body: some View {
        VStack(alignment: .trailing) {
            Spacer()

            Text("Leaderboard")
                .font(.heading5)
                .foregroundColor(.white)
                .onTapGesture {
                    viewModel.showLeaderboard()
                }

            DetailsView()

            Spacer()
        }
        .padding()
        .background(LinearGradient.background.ignoresSafeArea())
    }

}

struct QuizDetailsPreview: PreviewProvider {

    static var previews: some View {
        QuizDetailsView(viewModel: QuizDetailsViewModel())
    }

}

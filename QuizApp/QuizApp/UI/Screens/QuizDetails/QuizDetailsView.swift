import SwiftUI

struct QuizDetailsView: View {

    var body: some View {
        VStack(alignment: .trailing) {
            Spacer()

            Text("Leaderboard")
                .font(.heading5)
                .foregroundColor(.white)

            DetailsView()

            Spacer()
        }
        .padding()
        .background(LinearGradient.background.ignoresSafeArea())
    }

}

struct QuizDetailsPreview: PreviewProvider {

    static var previews: some View {
        QuizDetailsView()
    }

}

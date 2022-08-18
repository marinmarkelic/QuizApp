import SwiftUI

struct QuizDetailsView: View {

    var body: some View {
        VStack(alignment: .trailing) {
            Spacer()

            Text("Leaderboard")
                .font(.heading5)
                .foregroundColor(.white)

            VStack {
                Text("Title")
                    .font(.heading1)
                    .foregroundColor(.white)

                Text("Info")
                    .font(.heading4)
                    .foregroundColor(.white)

                Image(systemName: "circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()

                Button(action: {}, label: {
                    Text("Start Quiz")
                        .foregroundColor(.purpleText)
                        .font(.heading6)
                        .frame(maxWidth: .infinity)
                })
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(25)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.white.opacity(0.3))
            .cornerRadius(10)

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

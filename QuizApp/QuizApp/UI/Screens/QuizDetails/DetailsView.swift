import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {

    let quiz: Quiz

    let onStartQuizTap: () -> Void

    init(quiz: Quiz, onStartQuizTap: @escaping () -> Void = {}) {
        self.quiz = quiz
        self.onStartQuizTap = onStartQuizTap
    }

    var body: some View {
        VStack {
            Text(quiz.name)
                .font(.heading1)
                .foregroundColor(.white)
                .padding(.vertical, 15)

            Text(quiz.description)
                .font(.subtitle1)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            WebImage(url: URL(string: quiz.imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding(.vertical, 10)
                .frame(height: 200)

            Button(action: { onStartQuizTap() }, label: {
                Text("Start Quiz")
                    .foregroundColor(.purpleText)
                    .font(.heading6)
                    .maxWidth()
            })
            .padding()
            .background(.white)
            .cornerRadius(25)
        }
        .maxWidth()
        .padding()
        .background(.white.opacity(0.3))
        .cornerRadius(10)
    }

    func onStartQuizTap(_ onStartQuizTap: @escaping () -> Void = {}) -> DetailsView {
        DetailsView(quiz: quiz, onStartQuizTap: onStartQuizTap)
    }

}

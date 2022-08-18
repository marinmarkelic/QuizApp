import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {

    let quiz: Quiz

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
                .frame(maxHeight: 200)

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
    }

}

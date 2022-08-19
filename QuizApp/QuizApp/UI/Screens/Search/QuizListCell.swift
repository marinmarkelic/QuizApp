import SwiftUI
import SDWebImageSwiftUI

struct QuizListCell: View {

    var quiz: Quiz

    var body: some View {
        HStack {
            WebImage(url: URL(string: quiz.imageUrl))
                .resizable()
                .frame(width: 100, height: 100, alignment: .leading)
                .cornerRadius(5)
                .padding(.trailing)

            VStack(spacing: 0) {
                QuizListDifficultyView(difficulty: quiz.difficulty, uiColor: quiz.category.color)
                    .pushedRight()

                Text(quiz.name)
                    .font(.heading3)
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
                    .pushedLeft()

                Text(quiz.description)
                    .font(.subtitle3)
                    .foregroundColor(.white)
                    .pushedLeft()
            }
            .pushedUp()
        }
        .padding(20)
        .maxWidth()
        .background(.white.opacity(0.3))
        .cornerRadius(10)
    }

}

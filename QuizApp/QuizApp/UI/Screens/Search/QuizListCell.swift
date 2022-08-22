import SwiftUI
import SDWebImageSwiftUI

struct QuizListCell: View {

    let quiz: Quiz
    let onQuizTap: (Quiz) -> Void

    init(quiz: Quiz, onQuizTap: @escaping (Quiz) -> Void = { _ in }) {
        self.quiz = quiz
        self.onQuizTap = onQuizTap
    }

    var body: some View {
        HStack {
            WebImage(url: URL(string: quiz.imageUrl))
                .resizable()
                .frame(width: 100, height: 100, alignment: .leading)
                .cornerRadius(5)
                .padding(.trailing)

            VStack(alignment: .leading, spacing: 0) {
                QuizListDifficultyView(difficulty: quiz.difficulty, uiColor: quiz.category.color)
                    .pushedRight()

                Text(quiz.name)
                    .font(.heading3)
                    .foregroundColor(.white)
                    .padding(.bottom, 5)

                Text(quiz.description)
                    .font(.subtitle3)
                    .foregroundColor(.white)

                Spacer()
            }
        }
        .padding(20)
        .maxWidth()
        .background(.white.opacity(0.3))
        .cornerRadius(10)
        .onTapGesture {
            onQuizTap(quiz)
        }
    }

    func onQuizTap(_ onQuizTap: @escaping (Quiz) -> Void) -> QuizListCell {
        QuizListCell(quiz: quiz, onQuizTap: onQuizTap)
    }

}

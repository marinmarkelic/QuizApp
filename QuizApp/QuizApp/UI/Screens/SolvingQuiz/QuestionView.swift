import SwiftUI

struct QuestionView: View {

    let quiz: QuizStartResponse
    let currentQuestionIndex: Int
    let onAnswerTap: (Int) -> Void

    private var currentQuestion: Question {
        quiz.questions.count == 0 ?
            .empty :
            quiz.questions[currentQuestionIndex]
    }

    init(quiz: QuizStartResponse, currentQuestionIndex: Int, onAnswerTap: @escaping (Int) -> Void = { _ in }) {
        self.quiz = quiz
        self.currentQuestionIndex = currentQuestionIndex
        self.onAnswerTap = onAnswerTap
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text(currentQuestion.question)
                    .font(.heading3)
                    .foregroundColor(.white)

                ForEach(currentQuestion.answers, id: \.id) { answer in
                    Button(action: { onAnswerTap(answer.id) }, label: {
                        Text(answer.answer)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                            .font(.heading4)
                            .maxWidth(alignment: .leading)
                    })
                    .padding(.vertical, 20)
                    .padding(.horizontal, 25)
                    .background(Color(answer.color))
                    .cornerRadius(30)
                }
            }
        }
    }

    func onAnswerTap(onAnswerTap: @escaping (Int) -> Void) -> QuestionView {
        QuestionView(quiz: quiz, currentQuestionIndex: currentQuestionIndex, onAnswerTap: onAnswerTap)
    }

}

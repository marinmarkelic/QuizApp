import SwiftUI

struct SolvingQuizView: View {

    @ObservedObject var viewModel: SolvingQuizViewModel

    var body: some View {
        VStack(spacing: 50) {
            ProgressView(progressText: viewModel.progressText, progressColors: viewModel.progressColors)

            QuestionsView(quiz: viewModel.quiz, currentQuestionIndex: viewModel.currentQuestionIndex)
                .onAnswerTap {
                    viewModel.selectedAnswer(with: $0)
                }

            Spacer()
        }
        .maxWidth()
        .maxHeight()
        .padding()
        .background(LinearGradient.background.ignoresSafeArea())
    }

}

struct SolvingQuizPreview: PreviewProvider {

    static var previews: some View {
        SolvingQuizView(viewModel: SolvingQuizViewModel())
    }

}

struct QuestionsView: View {

    let quiz: QuizStartResponse
    let currentQuestionIndex: Int
    let onAnswerTap: (Int) -> Void

    var currentQuestion: Question {
        if quiz.questions.count == 0 {
            return .empty
        }

        return quiz.questions[currentQuestionIndex]
    }

    init(quiz: QuizStartResponse, currentQuestionIndex: Int, onAnswerTap: @escaping (Int) -> Void = { _ in }) {
        self.quiz = quiz
        self.currentQuestionIndex = currentQuestionIndex
        self.onAnswerTap = onAnswerTap
    }

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                QuestionView(text: currentQuestion.question, answers: currentQuestion.answers)
                    .onAnswerTap {
                        onAnswerTap($0)
                    }
            }
        }
    }

    func onAnswerTap(onAnswerTap: @escaping (Int) -> Void) -> QuestionsView {
        QuestionsView(quiz: quiz, currentQuestionIndex: currentQuestionIndex, onAnswerTap: onAnswerTap)
    }

}

struct QuestionView: View {

    let text: String
    let answers: [Answer]
    let onAnswerTap: (Int) -> Void

    init(text: String, answers: [Answer], onAnswerTap: @escaping (Int) -> Void = { _ in }) {
        self.text = text
        self.answers = answers
        self.onAnswerTap = onAnswerTap
    }

    var body: some View {
        VStack {
            Text(text)
                .font(.heading3)
                .foregroundColor(.white)
                .maxWidth(alignment: .leading)

            ForEach(answers, id: \.id) { answer in
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

    func onAnswerTap(onAnswerTap: @escaping (Int) -> Void) -> QuestionView {
        QuestionView(text: text, answers: answers, onAnswerTap: onAnswerTap)
    }

}

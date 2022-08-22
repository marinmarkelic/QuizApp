import SwiftUI

struct SolvingQuizView: View {

    @ObservedObject var viewModel: SolvingQuizViewModel

    var body: some View {
        VStack {
            ProgressView(progressText: viewModel.progressText, progressColors: viewModel.progressColors)

            Spacer()

            QuestionsView(quiz: viewModel.quiz, currentQuestionIndex: viewModel.currentQuestionIndex)

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

    var currentQuestion: Question {
        if quiz.questions.count == 0 {
            return .empty
        }

        return quiz.questions[currentQuestionIndex]
    }

    var body: some View {
        VStack {
            QuestionView(text: currentQuestion.question, answers: currentQuestion.answers)
        }
    }

}

struct QuestionView: View {

    let text: String
    let answers: [Answer]

    var body: some View {
        VStack {
            Text(text)
                .font(.heading3)
                .foregroundColor(.white)

            ForEach(answers, id: \.id) { answer in
                Button(action: {  }, label: {
                    Text(answer.answer)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .font(.heading4)
                        .maxWidth(alignment: .leading)
                })
                .padding()
                .background(.white.opacity(0.3))
                .cornerRadius(30)
            }
        }
    }

}

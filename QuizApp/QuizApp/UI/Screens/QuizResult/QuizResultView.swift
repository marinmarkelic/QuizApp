import SwiftUI

struct QuizResultView: View {

    @ObservedObject var viewModel: QuizResultViewModel

    var body: some View {
        VStack {
            Spacer()

            Text(viewModel.text)
                .font(.score)
                .foregroundColor(.white)

            Spacer()

            Button(action: { viewModel.exitQuiz() }, label: {
                Text("Finish Quiz")
                    .foregroundColor(.purpleText)
                    .font(.heading6)
                    .frame(maxWidth: .infinity)
            })
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(25)
        }
        .maxWidth()
        .maxHeight()
        .padding()
        .background(LinearGradient.background.ignoresSafeArea())
    }

}

struct QuizResultViewPreview: PreviewProvider {

    static var previews: some View {
        QuizResultView(viewModel: QuizResultViewModel())
    }

}

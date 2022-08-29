import SwiftUI

struct QuizResultView: View {

    @EnvironmentObject var states: QuizStates

    @ObservedObject var viewModel: QuizResultViewModel

    var body: some View {
        VStack {
            Spacer()

            Text(viewModel.text)
                .font(.score)
                .foregroundColor(.white)

            Spacer()

            Button(action: { states.reset() }, label: {
                Text("Finish Quiz")
                    .foregroundColor(.purpleText)
                    .font(.heading6)
                    .maxWidth()
            })
            .padding()
            .maxWidth()
            .background(.white)
            .cornerRadius(25)
        }
        .maxSize()
        .padding()
        .background(LinearGradient.background.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }

}

struct QuizResultViewPreview: PreviewProvider {

    static var previews: some View {
        QuizResultView(viewModel: QuizResultViewModel())
    }

}

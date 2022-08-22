import SwiftUI

struct SolvingQuizView: View {

    @ObservedObject var viewModel: SolvingQuizViewModel

    var body: some View {
        VStack {
            ProgressView(progressText: viewModel.progressText, progressColors: viewModel.progressColors)

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

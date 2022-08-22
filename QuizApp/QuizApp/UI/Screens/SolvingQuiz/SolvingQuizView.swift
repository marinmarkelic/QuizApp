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

struct ProgressView: View {

    let progressText: String
    let progressColors: [UIColor]

    var body: some View {
        VStack {
            Text(progressText)
                .font(.heading5)
                .foregroundColor(.white)
                .maxWidth(alignment: .leading)

            HStack(spacing: 5) {
                ForEach(progressColors) {color in
                    Rectangle()
                        .foregroundColor(Color(color))
                        .frame(height: 2)
                        .cornerRadius(2)
                }
            }
        }
    }
}

extension UIColor: Identifiable {}

import SwiftUI

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
                        .frame(height: 5)
                        .cornerRadius(2)
                }
            }
        }
    }
}

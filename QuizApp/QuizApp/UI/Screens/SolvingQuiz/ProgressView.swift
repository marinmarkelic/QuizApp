import SwiftUI

struct ProgressView: View {

    let progressText: String
    let progressData: [ProgressData]

    var body: some View {
        VStack(alignment: .leading) {
            Text(progressText)
                .font(.heading5)
                .foregroundColor(.white)

            HStack(spacing: 5) {
                ForEach(progressData) { data in
                    Rectangle()
                        .foregroundColor(data.color)
                        .frame(height: 5)
                        .cornerRadius(2)
                }
            }
        }
    }
}

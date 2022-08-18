import SwiftUI

struct LeaderboardHeader: View {

    var body: some View {
        HStack {
            Text("Player")
                .font(.subtitle2)
                .foregroundColor(.white.opacity(0.8))

            Spacer()

            Text("Points")
                .font(.subtitle2)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
    }

}

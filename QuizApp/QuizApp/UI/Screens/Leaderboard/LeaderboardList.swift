import SwiftUI

struct LeaderboardList: View {

    @Binding var leaderboard: Leaderboard

    var body: some View {
        ScrollView(.vertical) {
            ForEach(Array(leaderboard.leaderboardPoints.enumerated()), id: \.element.id) { index, element in
                Divider()
                    .background(.white.opacity(0.6))

                LeaderboardCell(index: index, data: element)
            }

            Divider()
                .background(.white.opacity(0.6))
        }
    }

}

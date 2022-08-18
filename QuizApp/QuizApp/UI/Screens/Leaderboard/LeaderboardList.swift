import SwiftUI

struct LeaderboardList: View {

    var leaderboard: Leaderboard

    var body: some View {
        ScrollView(.vertical) {
            ForEach(leaderboard.leaderboardPoints, id: \.index) {
                Divider()
                    .background(.white.opacity(0.6))

                LeaderboardCell(data: $0)
            }

            Divider()
                .background(.white.opacity(0.6))
        }
    }

}

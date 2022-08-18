import SwiftUI

struct LeaderboardList: View {

    @Binding var leaderboard: Leaderboard

    var body: some View {
        ScrollView(.vertical) {
            ForEach(Array(leaderboard.leaderboardPoints.enumerated()), id: \.element.id) { index, element in
                Divider()

                LeaderboardCell(index: index, data: element)
            }

            Divider()
        }
    }

}

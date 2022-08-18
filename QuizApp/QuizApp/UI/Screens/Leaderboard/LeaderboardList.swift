import SwiftUI

struct LeaderboardList: View {

    var body: some View {
        ScrollView(.vertical) {
            ForEach(mockData, id: \.name) {

                Divider()

                LeaderboardCell(data: $0)
            }

            Divider()
        }
    }

}

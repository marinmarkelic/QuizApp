import SwiftUI

struct LeaderboardCell: View {

    let data: LeaderboardPoints

    var body: some View {
        HStack {
            Text("\(data.index).")
                .font(.heading4)
                .foregroundColor(.white)

            Text(data.name)
                .font(.subtitle1)
                .foregroundColor(.white)

            Spacer()

            Text("\(data.points)")
                .font(.heading2)
                .foregroundColor(.white)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }

}

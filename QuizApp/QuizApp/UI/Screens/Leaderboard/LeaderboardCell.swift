import SwiftUI

struct LeaderboardCell: View {

    let index: Int
    let data: LeaderboardPoints

    var body: some View {
        HStack {
            Text("\(index + 1).")
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
        .padding([.leading, .trailing])
        .padding([.top, .bottom], 10)
    }

}

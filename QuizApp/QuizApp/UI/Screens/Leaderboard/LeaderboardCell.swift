import SwiftUI

struct LeaderboardCell: View {

    let data: MockResult

    var body: some View {
        HStack {
            Text("1.")
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
        .padding()
    }

}

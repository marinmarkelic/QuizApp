import SwiftUI

struct LeaderboardView: View {

    @ObservedObject var viewModel: LeaderboardViewModel

    var body: some View {
        VStack {
            LeaderboardHeader()

            LeaderboardList()

            Spacer()

        }
        .background(LinearGradient.background.ignoresSafeArea())
    }

}

struct LeaderboardPreview: PreviewProvider {

    static var previews: some View {
        LeaderboardView(viewModel: LeaderboardViewModel())
    }

}

public let mockData = [
    MockResult(name: "a", points: 21),
    MockResult(name: "b", points: 21),
    MockResult(name: "c", points: 21),
    MockResult(name: "d", points: 21)]

public struct MockResult {

    let name: String
    let points: Int

}

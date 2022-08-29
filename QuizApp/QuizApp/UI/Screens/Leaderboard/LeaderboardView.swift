import SwiftUI

struct LeaderboardView: View {

    @ObservedObject var viewModel: LeaderboardViewModel

    var body: some View {
        VStack {
            LeaderboardHeader()

            LeaderboardList(leaderboard: viewModel.leaderboard)

            Spacer()
        }
        .background(LinearGradient.background.ignoresSafeArea())
        .onAppear {
            viewModel.fetchLeaderboard()
        }
        .navigationBarTitle("Leaderboard")
    }

}

struct LeaderboardPreview: PreviewProvider {

    static var previews: some View {
        LeaderboardView(viewModel: LeaderboardViewModel())
    }

}

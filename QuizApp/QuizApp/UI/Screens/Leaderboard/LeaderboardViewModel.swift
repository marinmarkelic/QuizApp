import Combine

class LeaderboardViewModel: ObservableObject {

    private var id: Int!

    private var useCase: LeaderboardUseCaseProtocol!

    @Published var leaderboard: Leaderboard = .empty
    @Published var fetchingErrorMessage: String = ""
    @Published var noPlayersErrorMessage: String = ""

    init(id: Int, useCase: LeaderboardUseCaseProtocol) {
        self.id = id
        self.useCase = useCase
    }

    init() {}

    @MainActor
    func fetchLeaderboard() {
        guard let useCase = useCase else { return }

        Task {
            do {
                let response = try await useCase.fetchLeaderboard(for: id)
                leaderboard = Leaderboard(response)

                fetchingErrorMessage = ""
                noPlayersErrorMessage = leaderboard.leaderboardPoints.isEmpty ?
                "There are no results for this quiz." :
                ""
            } catch _ {
                noPlayersErrorMessage = ""
                fetchingErrorMessage = """
Leaderboard couldn't be loaded.
Please try again.
"""
            }
        }
    }

}

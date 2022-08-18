import Combine

class LeaderboardViewModel: ObservableObject {

    private var id: Int!

    private var useCase: LeaderboardUseCaseProtocol!
    private var router: AppRouterProtocol!

    @Published var leaderboard: Leaderboard = .empty
    @Published var fetchingErrorMessage: String = ""
    @Published var noPlayersErrorMessage: String = ""

    init(id: Int, useCase: LeaderboardUseCaseProtocol, router: AppRouterProtocol) {
        self.id = id
        self.useCase = useCase
        self.router = router
    }

    init() {}

    @MainActor
    func fetchLeaderboard() {
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

    func pressedClose() {
        router.goBack()
    }

}

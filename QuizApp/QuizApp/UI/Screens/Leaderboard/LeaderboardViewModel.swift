import Combine

class LeaderboardViewModel {

    private let id: Int

    private let useCase: LeaderboardUseCaseProtocol
    private let router: AppRouterProtocol

    @Published var leaderboard: Leaderboard = .empty

    init(id: Int, useCase: LeaderboardUseCaseProtocol, router: AppRouterProtocol) {
        self.id = id
        self.useCase = useCase
        self.router = router
    }

    @MainActor
    func fetchLeaderboard() {
        Task {
            do {
                let response = try await useCase.fetchLeaderboard(for: id)
                leaderboard = Leaderboard(response)
            } catch _ {}
        }
    }

    func pressedClose() {
        router.goBack()
    }

}

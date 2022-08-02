import Combine

class LeaderboardViewModel {

    private let id: Int

    private let useCase: LeaderboardUseCaseProtocol

    @Published var leaderboard: Leaderboard = .empty

    init(id: Int, useCase: LeaderboardUseCaseProtocol) {
        self.id = id
        self.useCase = useCase
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

}

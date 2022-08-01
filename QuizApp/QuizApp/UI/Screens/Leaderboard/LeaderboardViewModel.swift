import Combine

class LeaderboardViewModel {

    private let id: Int

    private let useCase: LeaderboardUseCaseProtocol

    @Published var leaderboard: Leaderboard = .empty

    init(id: Int, useCase: LeaderboardUseCaseProtocol) {
        self.id = id
        self.useCase = useCase
    }

    func fetchLeaderboard() {
        Task {
            do {
                let response = try await useCase.fetchLeaderboard(for: id)
                print(response)
            } catch let err {
                print(err)
            }
        }
    }

}

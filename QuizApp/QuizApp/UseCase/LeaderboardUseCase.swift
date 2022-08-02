protocol LeaderboardUseCaseProtocol {

    func fetchLeaderboard(for id: Int) async throws -> LeaderboardModel

}

class LeaderboardUseCase: LeaderboardUseCaseProtocol {

    private var repository: QuizRepository

    init(repository: QuizRepository) {
        self.repository = repository
    }

    func fetchLeaderboard(for id: Int) async throws -> LeaderboardModel {
        let response = try await repository.fetchLeaderboard(for: id)
        return LeaderboardModel(response)
    }

}

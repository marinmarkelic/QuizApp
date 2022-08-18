struct Leaderboard {

    let leaderboardPoints: [LeaderboardPoints]

}

struct LeaderboardPoints {

    let index: Int
    let name: String
    let points: Int

}

extension Leaderboard: Equatable {

    static let empty = Leaderboard(leaderboardPoints: [])

    init(_ model: LeaderboardModel) {
        leaderboardPoints = model.leaderboardPoints.enumerated().map({ index, element in
            LeaderboardPoints(element, index: index + 1)
        })
    }

}

extension LeaderboardPoints: Equatable {

    init(_ model: LeaderboardPointsModel, index: Int) {
        self.index = index
        name = model.name
        points = model.points
    }

}

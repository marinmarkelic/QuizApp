struct Leaderboard {

    let leaderboardPoints: [LeaderboardPoints]

}

struct LeaderboardPoints {

    let name: String
    let points: Int

}

extension Leaderboard {

    init(_ model: LeaderboardModel) {
        leaderboardPoints = model.leaderboardPoints.map({ LeaderboardPoints($0) })
    }

    static let empty = Leaderboard(leaderboardPoints: [])

}

extension LeaderboardPoints {

    init(_ model: LeaderboardPointsModel) {
        name = model.name
        points = model.points
    }

}

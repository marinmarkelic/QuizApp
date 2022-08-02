struct Leaderboard {

    let leaderboardPoints: [LeaderboardPoints]

}

struct LeaderboardPoints {

    let name: String
    let points: Int

}

extension Leaderboard {

    static let empty = Leaderboard(leaderboardPoints: [])

    init(_ model: LeaderboardModel) {
        leaderboardPoints = model.leaderboardPoints.map({ LeaderboardPoints($0) })
    }

}

extension LeaderboardPoints {

    init(_ model: LeaderboardPointsModel) {
        name = model.name
        points = model.points
    }

}

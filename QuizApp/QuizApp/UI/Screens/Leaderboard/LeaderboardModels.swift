import Foundation

struct Leaderboard {

    let leaderboardPoints: [LeaderboardPoints]

}

struct LeaderboardPoints: Identifiable {

    let id = UUID()
    let name: String
    let points: Int

}

extension Leaderboard: Equatable {

    static let empty = Leaderboard(leaderboardPoints: [])

    init(_ model: LeaderboardModel) {
        leaderboardPoints = model.leaderboardPoints.map({ LeaderboardPoints($0) })
    }

}

extension LeaderboardPoints: Equatable {

    init(_ model: LeaderboardPointsModel) {
        name = model.name
        points = model.points
    }

}

import UIKit

public let sportColor = UIColor(red: 242 / 255, green: 201 / 255, blue: 76 / 255, alpha: 1)
public let politicsColor = UIColor(red: 86 / 255, green: 204 / 255, blue: 242 / 255, alpha: 1)

public let categories: [Category] = [
    Category(name: "Sport", color: sportColor),
    Category(name: "Politics", color: politicsColor),
    Category(name: "MockCategory1", color: sportColor),
    Category(name: "MockCategory2", color: politicsColor),
    Category(name: "MockCategory3", color: sportColor),
    Category(name: "MockCategory4", color: politicsColor)
]

public let mockInfo: [Info] = [
    Info(
        title: "Football",
        description: "Quiz description that can usually span over multiple lines",
        difficulty: .easy),
    Info(
        title: "Olympics",
        description: "Quiz description that can usually span over multiple lines",
        difficulty: .medium),
    Info(
        title: "NBA",
        description: "Quiz description that can usually span over multiple lines",
        difficulty: .hard)
]

public struct Category {

    let name: String
    let color: UIColor

}

public struct Info {

    let title: String
    let description: String
    let difficulty: Difficulty

}

enum Difficulty: Int {

case easy = 1
case medium = 2
case hard = 3

}

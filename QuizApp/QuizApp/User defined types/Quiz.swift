import UIKit

enum Difficulty {

    case easy
    case medium
    case hard

}

enum CategoryName: String {

    case sport = "Sport"
    case politics = "Politics"
    case youtube = "Youtube"
    case animals = "Animals"

}

public struct Category: Equatable {

    let name: CategoryName
    let color: UIColor

}

extension Category {

    init(name: CategoryName) {
        self.name = name
        self.color = .white
    }

}

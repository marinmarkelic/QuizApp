import UIKit

enum Difficulty {

    case easy
    case medium
    case hard

}

enum CategoryType: CaseIterable {

    case sport
    case politics
    case youtube
    case animals

}

struct Category: Equatable {

    let type: CategoryType
    let color: UIColor
    var name: String {
        switch type {
        case .sport:
            return "Sport"
        case .politics:
            return "Politics"
        case .youtube:
            return "Youtube"
        case .animals:
            return "Animals"
        }
    }

}

extension Category {

    init(type: CategoryType) {
        self.type = type
        self.color = .white
    }

}

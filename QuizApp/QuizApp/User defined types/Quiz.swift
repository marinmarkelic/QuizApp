import UIKit

enum Difficulty: String {

    case easy = "EASY"
    case normal = "NORMAL"
    case hard = "HARD"

}

struct Category {

    let name: String
    let color: UIColor
    var isSelected: Bool

}

import UIKit

public let sportColor = UIColor(red: 242 / 255, green: 201 / 255, blue: 76 / 255, alpha: 1)
public let moviesColor = UIColor(red: 86 / 255, green: 204 / 255, blue: 242 / 255, alpha: 1)
public let musicColor = UIColor(red: 242 / 255, green: 24 / 255, blue: 24 / 255, alpha: 1)
public let geographyColor = UIColor(red: 117 / 255, green: 74 / 255, blue: 21 / 255, alpha: 1)

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

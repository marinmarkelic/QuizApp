import UIKit

enum Difficulty {

case easy
case medium
case hard

}

public struct Category: Equatable {

    let name: String
    var color: UIColor = .white

}

import UIKit

struct Quiz: Equatable {

    let id: Int
    let name: String
    let description: String
    var category: Category
    let difficulty: Difficulty
    let imageUrl: String
    let numberOfQuestions: Int

}

extension Quiz {

    static let empty = Quiz(
        id: 0,
        name: "",
        description: "",
        category: Category(from: .all),
        difficulty: .easy,
        imageUrl: "",
        numberOfQuestions: 0)

    init(_ quiz: QuizModel) {
        id = quiz.id
        name = quiz.name
        description = quiz.description
        category = Category(from: quiz.category)
        difficulty = Difficulty(rawValue: quiz.difficulty.rawValue)!
        imageUrl = quiz.imageUrl
        numberOfQuestions = quiz.numberOfQuestions
    }

}

enum Difficulty: String, Comparable {

    var level: Int {
        switch self {
        case .easy:
            return 1
        case .normal:
            return 2
        case .hard:
            return 3
        }
    }

    case easy = "EASY"
    case normal = "NORMAL"
    case hard = "HARD"

    static func < (lhs: Difficulty, rhs: Difficulty) -> Bool {
        lhs.level < rhs.level
    }

}

enum CategoryType: String, CaseIterable {

    case all = "ALL"
    case sport = "SPORT"
    case movies = "MOVIES"
    case music = "MUSIC"
    case geography = "GEOGRAPHY"

}

struct Category: Hashable {

    var name: String {
        switch type {
        case .sport:
            return "Sport"
        case .movies:
            return "Movies"
        case .music:
            return "Music"
        case .geography:
            return "Geography"
        case .all:
            return "All"
        }
    }

    var index: Int {
        switch type {
        case .sport:
            return 1
        case .movies:
            return 2
        case .music:
            return 3
        case .geography:
            return 4
        case .all:
            return 0
        }
    }

    let type: CategoryType
    let color: UIColor

}

extension Category {

    init(from type: CategoryType) {
        self.type = type
        color = .white
    }

    init(from model: CategoryModel) {
        switch model {
        case .sport:
            self.init(type: CategoryType.sport, color: .sport)
        case .movies:
            self.init(type: CategoryType.movies, color: .movies)
        case .music:
            self.init(type: CategoryType.music, color: .music)
        case .geography:
            self.init(type: CategoryType.geography, color: .geography)
        }
    }

}

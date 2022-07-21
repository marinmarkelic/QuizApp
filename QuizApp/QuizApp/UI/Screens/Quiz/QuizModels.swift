import UIKit

struct Quiz {

    let id: Int
    let name: String
    let description: String
    var category: Category
    let difficulty: Difficulty
    let imageUrl: String
    let numberOfQuestions: Int

}

extension Quiz {

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

enum Difficulty: String {

    case easy = "EASY"
    case normal = "NORMAL"
    case hard = "HARD"

}

enum CategoryType: CaseIterable {

    case sport
    case movies
    case music
    case geography
    case all

}

struct Category: Equatable {

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
            self.init(type: CategoryType.sport, color: .sportColor)
        case .movies:
            self.init(type: CategoryType.movies, color: .moviesColor)
        case .music:
            self.init(type: CategoryType.music, color: .musicColor)
        case .geography:
            self.init(type: CategoryType.geography, color: .geographyColor)
        }
    }

}

struct QuizModel {

    let id: Int
    let name: String
    let description: String
    let category: CategoryModel
    let difficulty: DifficultyModel
    let imageUrl: String
    let numberOfQuestions: Int

}

extension QuizModel {

    init(_ quiz: QuizRepoModel) {
        id = quiz.id
        name = quiz.name
        description = quiz.description
        category = CategoryModel(rawValue: quiz.category.rawValue)!
        difficulty = DifficultyModel(rawValue: quiz.difficulty.rawValue)!
        imageUrl = quiz.imageUrl
        numberOfQuestions = quiz.numberOfQuestions
    }

}

enum CategoryModel: String {

    case sport = "SPORT"
    case movies = "MOVIES"
    case music = "MUSIC"
    case geography = "GEOGRAPHY"

}

enum DifficultyModel: String {

    case easy = "EASY"
    case normal = "NORMAL"
    case hard = "HARD"

}

struct QuizRepoModel {

    let id: Int
    let name: String
    let description: String
    let category: CategoryRepoModel
    let difficulty: DifficultyRepoModel
    let imageUrl: String
    let numberOfQuestions: Int

}

extension QuizRepoModel {

    init(_ quiz: QuizResponseDataModel) {
        id = quiz.id
        name = quiz.name
        description = quiz.description
        category = CategoryRepoModel(rawValue: quiz.category.rawValue)!
        difficulty = DifficultyRepoModel(rawValue: quiz.difficulty.rawValue)!
        imageUrl = quiz.imageUrl
        numberOfQuestions = quiz.numberOfQuestions
    }

}

enum CategoryRepoModel: String {

    case sport = "SPORT"
    case movies = "MOVIES"
    case music = "MUSIC"
    case geography = "GEOGRAPHY"

}

enum DifficultyRepoModel: String {

    case easy = "EASY"
    case normal = "NORMAL"
    case hard = "HARD"

}

struct QuizResponseDataModel {

    let id: Int
    let name: String
    let description: String
    let category: CategoryDataModel
    let difficulty: DifficultyDataModel
    let imageUrl: String
    let numberOfQuestions: Int

}

extension QuizResponseDataModel {

    init(_ quiz: QuizNetworkDataModel) {
        id = quiz.id
        name = quiz.name
        description = quiz.description
        category = CategoryDataModel(rawValue: quiz.category.rawValue)!
        difficulty = DifficultyDataModel(rawValue: quiz.difficulty.rawValue)!
        imageUrl = quiz.imageUrl
        numberOfQuestions = quiz.numberOfQuestions
    }

}

enum CategoryDataModel: String {

    case sport = "SPORT"
    case movies = "MOVIES"
    case music = "MUSIC"
    case geography = "GEOGRAPHY"

}

enum DifficultyDataModel: String {

    case easy = "EASY"
    case normal = "NORMAL"
    case hard = "HARD"

}

struct QuizNetworkDataModel: Decodable {

    let id: Int
    let name: String
    let description: String
    let category: CategoryNetworkDataModel
    let difficulty: DifficultyNetworkDataModel
    let imageUrl: String
    let numberOfQuestions: Int

}

enum CategoryNetworkDataModel: String, Decodable {

    case sport = "SPORT"
    case movies = "MOVIES"
    case music = "MUSIC"
    case geography = "GEOGRAPHY"

}

enum DifficultyNetworkDataModel: String, Decodable {

    case easy = "EASY"
    case normal = "NORMAL"
    case hard = "HARD"

}

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

    private var level: Int {
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

struct QuizStartRequest {

    let id: Int

}

extension QuizStartRequestModel {

    init(_ request: QuizStartRequest) {
        id = request.id
    }

}

struct QuizStartResponse {

    let questions: [Question]
    let sessionId: String

}

extension QuizStartResponse {

    static var empty = QuizStartResponse(questions: [], sessionId: "")

    init(_ model: QuizStartResponse, id: Int, selectedAnswerId: Int) {
        questions = model.questions.map { $0.id == id ? Question($0, selectedAnswerId: selectedAnswerId) : $0 }
        sessionId = model.sessionId
    }

}

struct Question {

    let id: Int
    let answers: [Answer]
    let correctAnswerId: Int
    let question: String

}

extension Question {

    init(_ model: Question, selectedAnswerId: Int) {
        id = model.id
        answers = model.answers.map {
            if selectedAnswerId == model.correctAnswerId {
                return Answer(
                    $0,
                    color: $0.id == model.correctAnswerId ? .correctAnswerColor : .white.withAlphaComponent(0.3))
            } else {
                if $0.id == selectedAnswerId {
                    return Answer($0, color: .incorrectAnswerColor)
                } else if $0.id == model.correctAnswerId {
                    return Answer($0, color: .correctAnswerColor)
                } else {
                    return Answer($0, color: .white.withAlphaComponent(0.3))
                }
            }
        }
        self.correctAnswerId = model.correctAnswerId
        question = model.question
    }

}

struct Answer {

    let id: Int
    let answer: String
    let color: UIColor

}

extension Answer {

    init(_ model: Answer, color: UIColor) {
        id = model.id
        answer = model.answer
        self.color = color
    }

}

extension QuizStartResponse: Equatable {

    init(_ response: QuizStartResponseModel) {
        questions = response.questions.map { Question($0) }
        sessionId = response.sessionId
    }

}

extension Question: Equatable {

    init(_ question: QuestionModel) {
        answers = question.answers.map { Answer($0) }
        correctAnswerId = question.correctAnswerId
        id = question.id
        self.question = question.question
    }

}

extension Answer: Equatable {

    init(_ answer: AnswerModel) {
        self.answer = answer.answer
        id = answer.id
        color = .white.withAlphaComponent(0.3)
    }

}

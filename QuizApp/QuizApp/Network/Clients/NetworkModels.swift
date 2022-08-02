struct LoginRequestNetworkDataModel: Encodable {

    let username: String
    let password: String

}

struct LoginResponseNetworkDataModel: Decodable {

    let accessToken: String

}

struct UserInfoNetworkDataModel: Decodable {

    let id: Int
    let email: String
    let name: String

}

struct UserInfoNetworkRequestModel: Encodable {

    let name: String

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

struct QuizStartRequestNetworkDataModel: Encodable {

    let id: Int

}

struct QuizStartResponseNetworkDataModel: Decodable {

    let questions: [QuestionNetworkDataModel]
    let sessionId: String

}

struct QuestionNetworkDataModel: Decodable {

    let answers: [AnswerNetworkDataModel]
    let correctAnswerId: Int
    let id: Int
    let question: String

}

struct AnswerNetworkDataModel: Decodable {

    let answer: String
    let id: Int

}

struct QuizEndRequestNetworkDataModel: Encodable {

    let numberOfCorrectQuestions: Int

}

struct QuizEndResponseNetworkDataModel: Decodable {

    let points: Int

}

struct LeaderboardPointsNetworkDataModel: Decodable {

    let name: String
    let points: Int

}

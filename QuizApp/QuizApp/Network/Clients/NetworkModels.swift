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

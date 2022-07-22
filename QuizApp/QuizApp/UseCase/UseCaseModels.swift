struct LoginResponseModel {

    let accessToken: String

}

extension LoginResponseModel {

    init(_ loginResponse: LoginResponseRepoModel) {
        accessToken = loginResponse.accessToken
    }

}

struct UserInfoModel {

    let username: String
    let name: String

}

extension UserInfoModel {

    init(_ userInfo: UserInfoRepoModel) {
        username = userInfo.username
        name = userInfo.name
    }

}

extension UserInfoRepoModel {

    init(_ userInfo: UserInfoModel) {
        username = userInfo.username
        name = userInfo.name
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

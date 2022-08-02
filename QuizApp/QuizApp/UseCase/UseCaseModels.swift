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

struct QuizStartRequestModel {

    let id: Int

}

extension QuizStartRequestRepoModel {

    init(_ request: QuizStartRequestModel) {
        id = request.id
    }

}

struct QuizStartResponseModel {

    let questions: [QuestionModel]
    let sessionId: String

}

struct QuestionModel {

    let answers: [AnswerModel]
    let correctAnswerId: Int
    let id: Int
    let question: String

}

struct AnswerModel {

    let answer: String
    let id: Int

}

extension QuizStartResponseModel {

    init(_ response: QuizStartResponseRepoModel) {
        questions = response.questions.map { QuestionModel($0) }
        sessionId = response.sessionId
    }

}

extension QuestionModel {

    init(_ question: QuestionRepoModel) {
        answers = question.answers.map { AnswerModel($0) }
        correctAnswerId = question.correctAnswerId
        id = question.id
        self.question = question.question
    }

}

extension AnswerModel {

    init(_ answer: AnswerRepoModel) {
        self.answer = answer.answer
        id = answer.id
    }

}

struct QuizEndRequestModel {

    let id: String
    let numberOfCorrectQuestions: Int

}

extension QuizEndRequestRepoModel {

    init(_ model: QuizEndRequestModel) {
        id = model.id
        numberOfCorrectQuestions = model.numberOfCorrectQuestions
    }

}

struct QuizEndResponseModel {

    let points: Int

}

extension QuizEndResponseModel {

    init(_ model: QuizEndResponseRepoModel) {
        points = model.points
    }

}

struct LeaderboardModel {

    let leaderboardPoints: [LeaderboardPointsModel]

}

struct LeaderboardPointsModel {

    let name: String
    let points: Int

}

extension LeaderboardModel {

    init(_ model: LeaderboardRepoModel) {
        leaderboardPoints = model.leaderboardPoints.map { LeaderboardPointsModel($0) }
    }

}

extension LeaderboardPointsModel {

    init(_ model: LeaderboardPointsRepoModel) {
        name = model.name
        points = model.points
    }

}

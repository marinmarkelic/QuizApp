struct LoginResponseRepoModel {

    var accessToken: String

}

extension LoginResponseRepoModel {

    init(_ responseDataModel: LoginResponseDataModel) {
        accessToken = responseDataModel.accessToken
    }

}

struct UserInfoRepoModel {

    let username: String
    let name: String

}

extension UserInfoRepoModel {

    init(_ userInfo: UserInfoDataModel) {
        username = userInfo.email
        name = userInfo.name
    }

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

extension QuizRepoModel {

    init(_ model: QuizDatabaseModel) {
        id = model.id
        name = model.name
        description = model.desc
        category = CategoryRepoModel(rawValue: model.category)!
        difficulty = DifficultyRepoModel(rawValue: model.difficulty)!
        imageUrl = model.imageUrl
        numberOfQuestions = model.numberOfQuestions
    }
}

extension QuizDatabaseModel {

    convenience init(_ model: QuizRepoModel) {
        self.init()

        id = model.id
        name = model.name
        desc = model.description
        category = model.category.rawValue
        difficulty = model.difficulty.rawValue
        imageUrl = model.imageUrl
        numberOfQuestions = model.numberOfQuestions
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

struct QuizStartRequestRepoModel {

    let id: Int

}

extension QuizStartRequestDataModel {

    init(_ request: QuizStartRequestRepoModel) {
        id = request.id
    }

}

struct QuizStartResponseRepoModel {

    let questions: [QuestionRepoModel]
    let sessionId: String

}

struct QuestionRepoModel {

    let answers: [AnswerRepoModel]
    let correctAnswerId: Int
    let id: Int
    let question: String

}

struct AnswerRepoModel {

    let answer: String
    let id: Int

}

extension QuizStartResponseRepoModel {

    init(_ response: QuizStartResponseDataModel) {
        questions = response.questions.map { QuestionRepoModel($0) }
        sessionId = response.sessionId
    }

}

extension QuestionRepoModel {

    init(_ question: QuestionDataModel) {
        answers = question.answers.map { AnswerRepoModel($0) }
        correctAnswerId = question.correctAnswerId
        id = question.id
        self.question = question.question
    }

}

extension AnswerRepoModel {

    init(_ answer: AnswerDataModel) {
        self.answer = answer.answer
        id = answer.id
    }

}

struct QuizEndRequestRepoModel {

    let id: String
    let numberOfCorrectQuestions: Int

}

extension QuizEndRequestDataModel {

    init(_ model: QuizEndRequestRepoModel) {
        id = model.id
        numberOfCorrectQuestions = model.numberOfCorrectQuestions
    }

}

struct QuizEndResponseRepoModel {

    let points: Int

}

extension QuizEndResponseRepoModel {

    init(_ model: QuizEndResponseDataModel) {
        points = model.points
    }

}

struct LeaderboardRepoModel {

    let leaderboardPoints: [LeaderboardPointsRepoModel]

}

struct LeaderboardPointsRepoModel {

    let name: String
    let points: Int

}

extension LeaderboardRepoModel {

    init(_ model: LeaderboardDataModel) {
        leaderboardPoints = model.leaderboardPoints.map { LeaderboardPointsRepoModel($0) }
    }

}

extension LeaderboardPointsRepoModel {

    init(_ model: LeaderboardPointsDataModel) {
        name = model.name
        points = model.points
    }

}

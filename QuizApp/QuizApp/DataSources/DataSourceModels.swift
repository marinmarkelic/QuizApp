struct LoginResponseDataModel {

    let accessToken: String

}

extension LoginResponseDataModel {

    init(_ loginResponse: LoginResponseNetworkDataModel) {
        accessToken = loginResponse.accessToken
    }

}

struct UserInfoDataModel {

    let id: Int
    let email: String
    let name: String

}

extension UserInfoDataModel {

    init(_ userData: UserInfoNetworkDataModel) {
        email = userData.email
        id = userData.id
        name = userData.name
    }

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

struct QuizStartRequestDataModel {

    let id: Int

}

extension QuizStartRequestNetworkDataModel {

    init(_ request: QuizStartRequestDataModel) {
        id = request.id
    }

}

struct QuizStartResponseDataModel {

    let questions: [QuestionDataModel]
    let sessionId: String

}

struct QuestionDataModel {

    let answers: [AnswerDataModel]
    let correctAnswerId: Int
    let id: Int
    let question: String

}

struct AnswerDataModel {

    let answer: String
    let id: Int

}

extension QuizStartResponseDataModel {

    init(_ response: QuizStartResponseNetworkDataModel) {
        questions = response.questions.map { QuestionDataModel($0) }
        sessionId = response.sessionId
    }

}

extension QuestionDataModel {

    init(_ question: QuestionNetworkDataModel) {
        answers = question.answers.map { AnswerDataModel($0) }
        correctAnswerId = question.correctAnswerId
        id = question.id
        self.question = question.question
    }

}

extension AnswerDataModel {

    init(_ answer: AnswerNetworkDataModel) {
        self.answer = answer.answer
        id = answer.id
    }

}

struct QuizEndRequestDataModel {

    let id: String
    let numberOfCorrectQuestions: Int

}

extension QuizEndRequestNetworkDataModel {

    init(_ model: QuizEndRequestDataModel) {
        numberOfCorrectQuestions = model.numberOfCorrectQuestions
    }

}

struct QuizEndResponseDataModel {

    let points: Int

}

extension QuizEndResponseDataModel {

    init(_ model: QuizEndResponseNetworkDataModel) {
        points = model.points
    }

}

struct LeaderboardDataModel {

    let leaderboardPoints: [LeaderboardPointsDataModel]

}

struct LeaderboardPointsDataModel {

    let name: String
    let points: Int

}

extension LeaderboardDataModel {

    init(_ points: [LeaderboardPointsNetworkDataModel]) {
        leaderboardPoints = points.map { LeaderboardPointsDataModel($0) }
    }

}

extension LeaderboardPointsDataModel {

    init(_ model: LeaderboardPointsNetworkDataModel) {
        name = model.name
        points = model.points
    }

}

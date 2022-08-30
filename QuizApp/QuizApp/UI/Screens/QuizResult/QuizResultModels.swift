struct QuizResult: Equatable {

    let sessionId: String
    let correctQuestions: Int
    let totalQuestions: Int

}

extension QuizResult {

    static let empty = QuizResult(sessionId: "", correctQuestions: 0, totalQuestions: 0)

}

enum AppRoute: Equatable {

    case quizzes
    case search
    case settings

}

enum QuizAppRoute: Equatable {

    case all
    case details(_ quiz: Quiz)
    case leaderboard(_ id: Int)
    case solving(_ quizId: Int)
    case finished(_ results: QuizResult)

}

enum SearchAppRoute: Equatable {

    case search
    case details(_ quiz: Quiz)
    case leaderboard(_ id: Int)
    case solving(_ quizId: Int)
    case finished(_ results: QuizResult)

}

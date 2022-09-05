enum AppRoute: Equatable {

    case quizzes
    case search
    case settings

}

enum QuizAppRoute: Equatable {

    case all
    case details(Quiz)
    case leaderboard(Int)
    case solving(Int)
    case finished(QuizResult)

}

enum SearchAppRoute: Equatable {

    case search
    case details(Quiz)
    case leaderboard(Int)
    case solving(Int)
    case finished(QuizResult)

}

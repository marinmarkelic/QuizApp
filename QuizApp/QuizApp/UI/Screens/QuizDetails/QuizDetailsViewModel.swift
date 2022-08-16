import Combine

class QuizDetailsViewModel {

    private let router: AppRouterProtocol

    @Published var quiz: Quiz

    init(quiz: Quiz, router: AppRouterProtocol) {
        self.quiz = quiz
        self.router = router
    }

    @MainActor
    func startQuiz() {
        router.showQuiz(with: quiz.id)
    }

    func goBack() {
        router.goBack()
    }

    func showLeaderboard() {
        router.showLeaderboard(with: quiz.id)
    }

}

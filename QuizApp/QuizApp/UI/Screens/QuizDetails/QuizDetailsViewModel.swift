import Combine

class QuizDetailsViewModel: ObservableObject {

    @Published var quiz: Quiz!

    private var router: AppRouterProtocol!

    init(quiz: Quiz, router: AppRouterProtocol) {
        self.quiz = quiz
        self.router = router
    }

    init() {}

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

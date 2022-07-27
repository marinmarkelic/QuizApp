import Combine

class QuizDetailsViewModel {

    private let appRouter: AppRouterProtocol

    @Published var quiz: Quiz

    init(quiz: Quiz, appRouter: AppRouterProtocol) {
        self.quiz = quiz
        self.appRouter = appRouter
    }

    @MainActor
    func startQuiz() {
        appRouter.showQuiz(with: quiz.id)
    }

    func goBack() {
        appRouter.goBack()
    }

}

import Combine

class SearchViewModel {

    private let router: AppRouterProtocol
    private let useCase: QuizUseCaseProtocol

    private var searchText: String = ""

    @Published var quizzes: [Quiz] = []
    @Published var fetchingErrorMessage: String = ""
    @Published var noQuizzesErrorMessage: String = ""

    init(router: AppRouterProtocol, useCase: QuizUseCaseProtocol) {
        self.router = router
        self.useCase = useCase
    }

    @MainActor
    func fetchQuizzes() {
        Task {
            do {
                let quizzes = try await useCase.fetchAllQuizzes()

                if searchText == "" {
                    self.quizzes = quizzes.map { Quiz($0) }
                    return
                }

                self.quizzes = quizzes
                    .filter { $0.name.lowercased().contains(searchText.lowercased()) }
                    .map { Quiz($0) }

                fetchingErrorMessage = ""
                noQuizzesErrorMessage = self.quizzes.isEmpty ?
                "No quizzes found." :
                ""

            } catch _ {
                noQuizzesErrorMessage = ""
                fetchingErrorMessage = """
Quizzes couldn't be loaded.
Please try again.
"""
            }
        }
    }

    func updatedSearchText(with text: String) {
        searchText = text
    }

    func showQuizDetails(with quiz: Quiz) {
        router.showQuizDetails(with: quiz)
    }

}

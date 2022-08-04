import Combine

class SearchViewModel {

    private let useCase: QuizUseCaseProtocol

    private var searchText: String = ""

    @Published var quizzes: [Quiz] = []

    init(useCase: QuizUseCaseProtocol) {
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
                    .filter {
                        $0.name.lowercased().contains(searchText.lowercased())
                    }
                    .map {
                        Quiz($0)
                    }
            } catch let err {
                print(err) // change
            }
        }
    }

    func updatedSearchText(with text: String) {
        searchText = text
    }

}

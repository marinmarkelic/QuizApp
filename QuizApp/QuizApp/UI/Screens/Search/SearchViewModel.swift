import Combine

class SearchViewModel {

    private let useCase: QuizUseCaseProtocol

    @Published var quizzes: [Quiz] = []

    init(useCase: QuizUseCaseProtocol) {
        self.useCase = useCase
    }

    @MainActor
    func fetchQuizzes(with text: String) {
        Task {
            do {
                let quizzes = try await useCase.fetchAllQuizzes()
                self.quizzes = quizzes
                    .filter {
                        $0.name.lowercased().contains(text.lowercased())
                    }
                    .map {
                        Quiz($0)
                    }
            } catch let err {
                print(err) // change
            }
        }
    }

}

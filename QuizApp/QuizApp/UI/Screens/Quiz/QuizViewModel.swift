import Combine
import UIKit

class QuizViewModel: ObservableObject {

    @Published var quizzes: [Quiz] = []
    @Published var categories: [Category] = []
    @Published var errorMessage: String = ""

    private var useCase: QuizUseCaseProtocol!

    init(useCase: QuizUseCaseProtocol) {
        self.useCase = useCase
    }

    init() {}

    func showQuizDetails(with quiz: Quiz) {
    }

    @MainActor
    func loadCategories() {
        categories = CategoryType
            .allCases
            .map { Category(from: $0) }

        changeCategory(for: categories[0].type)
    }

    @MainActor
    func changeCategory(for type: CategoryType) {
        categories = CategoryType
            .allCases
            .map { Category(type: $0, color: $0 == type ? findColor(for: type) : .white) }

        fetchCategoryQuizzes(for: type)
    }

    @MainActor
    private func fetchCategoryQuizzes(for type: CategoryType) {
        Task {
            do {
                errorMessage = ""
                try await fetchQuizzes(for: type)
            } catch _ {
                errorMessage = """
Data can't be reached.
Please try again
"""
            }
        }
    }

    @MainActor
    private func fetchQuizzes(for type: CategoryType) async throws {
        guard let useCase = useCase else { return }

        let quizzes: [QuizModel]

        guard let categoryModel = CategoryModel(rawValue: type.rawValue) else {
            quizzes = try await useCase.fetchAllQuizzes()
            self.quizzes = quizzes
                .map { Quiz($0) }
                .sorted()
            return
        }

        quizzes = try await useCase.fetchQuizzes(for: categoryModel)
        self.quizzes = quizzes
            .map { Quiz($0) }
            .sorted()
    }

    private func findColor(for type: CategoryType) -> UIColor {
        switch type {
        case .sport:
            return .sport
        case .movies:
            return .movies
        case .music:
            return .music
        case .geography:
            return .geography
        case .all:
            return .all
        }
    }

}

import Combine
import UIKit

class QuizViewModel {

    private let router: AppRouterProtocol
    private let useCase: QuizUseCaseProtocol

    @Published var quizzes: [Quiz] = []
    @Published var categories: [Category] = []
    @Published var errorMessage: String = ""

    init(router: AppRouterProtocol, useCase: QuizUseCaseProtocol) {
        self.router = router
        self.useCase = useCase
    }

    func showQuizDetails(with quiz: Quiz) {
        router.showQuizDetails(with: quiz)
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
        let quizzes: [QuizModel]

        guard let categoryModel = CategoryModel(rawValue: type.rawValue) else {
            quizzes = try await useCase.fetchAllQuizzes()
            self.quizzes = quizzes
                .map { Quiz($0) }
            return
        }

        quizzes = try await useCase.fetchQuizzes(for: categoryModel)
        self.quizzes = quizzes
            .map { Quiz($0) }
    }

    private func findColor(for type: CategoryType) -> UIColor {
        switch type {
        case .sport:
            return .sportColor
        case .movies:
            return .moviesColor
        case .music:
            return .musicColor
        case .geography:
            return .geographyColor
        case .all:
            return .allColor
        }
    }

}

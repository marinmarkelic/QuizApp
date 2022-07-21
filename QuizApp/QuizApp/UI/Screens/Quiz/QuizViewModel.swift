import Combine
import UIKit

class QuizViewModel {

    private let quizUseCase: QuizUseCaseProtocol

    @Published var quizzes: [Quiz] = []
    @Published var categories: [Category] = []

    init(quizUseCase: QuizUseCaseProtocol) {
        self.quizUseCase = quizUseCase
    }

    @MainActor
    func changeCategory(for type: CategoryType) {
        quizzes = []

        categories = CategoryType
            .allCases
            .map { Category(type: $0, color: $0 == type ? findColor(for: type) : .white) }

        loadCategory(for: type)
    }

    @MainActor
    private func loadCategory(for type: CategoryType) {
        Task {
            do {
                try await fetchQuizzes(for: type)
            } catch _ {

            }
        }
    }

    @MainActor
    private func fetchQuizzes(for type: CategoryType) async throws {
        let quizzes: [QuizModel]

        guard let categoryModel = getCategoryModel(from: type) else {
            quizzes = try await quizUseCase.fetchAllQuizzes()
            self.quizzes = quizzes
                .map { Quiz($0) }
            return
        }

        quizzes = try await quizUseCase.fetchQuizzes(for: categoryModel)
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

    private func getCategoryModel(from type: CategoryType) -> CategoryModel? {
        switch type {
        case .sport:
            return CategoryModel.sport
        case .movies:
            return CategoryModel.movies
        case .music:
            return CategoryModel.music
        case .geography:
            return CategoryModel.geography
        case .all:
            return nil
        }
    }

    @MainActor
    func loadCategories() {
        categories = CategoryType
            .allCases
            .map { Category(from: $0) }

        changeCategory(for: categories[0].type)
    }

}

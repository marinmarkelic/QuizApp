import Combine
import UIKit

class QuizViewModel {

    private let quizUseCase: QuizUseCaseProtocol

    @Published var quizzes: [Quiz] = []
    @Published var categories: [Category] = []
    @Published var selectedCategory: CategoryType = .all

    init(quizUseCase: QuizUseCaseProtocol) {
        self.quizUseCase = quizUseCase
    }

    @MainActor
    func changeCategory(for type: CategoryType) {
        selectedCategory = type
        quizzes = []

        categories = CategoryType
            .allCases
            .map { Category(type: $0, color: $0 == type ? findColor(for: type) : .white) }

        if type == .all {
            loadAllCategories()
        } else {
            loadCategory(for: type)
        }
    }

    @MainActor
    private func loadCategory(for type: CategoryType) {
        Task {
            do {
                let quizzes = try await fetchQuizzes(for: type)
                self.quizzes = quizzes
                    .map { Quiz($0) }
            } catch _ {

            }
        }
    }

    @MainActor
    private func loadAllCategories() {
        Task {
            do {
                for type in CategoryType.allCases
                where type != .all {
                    let quizzes = try await fetchQuizzes(for: type)
                    self.quizzes.append(
                        contentsOf: quizzes
                            .map { Quiz($0) })
                }
            } catch _ {

            }
        }
    }

    private func fetchQuizzes(for category: CategoryType) async throws -> [QuizModel] {
        guard let category = getCategoryModel(from: category) else {
            return []
        }

        return try await quizUseCase.fetchQuizzes(for: category)
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

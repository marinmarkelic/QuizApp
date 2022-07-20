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
        categories = CategoryType
            .allCases
            .map { Category(type: $0, color: $0 == type ? findColor(for: type) : .white) }

        Task {
            do {
                let quizzes = try await quizUseCase.fetchQuizzes(for: getCategoryModel(from: type))
                self.quizzes = quizzes
                    .map { Quiz($0) }
            } catch _ {

            }
        }
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
        }
    }

    private func getCategoryModel(from type: CategoryType) -> CategoryModel {
        switch type {
        case .sport:
            return CategoryModel.sport
        case .movies:
            return CategoryModel.movies
        case .music:
            return CategoryModel.music
        case .geography:
            return CategoryModel.geography
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

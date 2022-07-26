import Combine
import UIKit
import Resolver

class QuizViewModel {

    private let quizUseCase: QuizUseCaseProtocol
    private let container: Resolver

    @Published var quizzes: [Quiz] = []
    @Published var categories: [Category] = []
    @Published var errorMessage: String = ""

    init(quizUseCase: QuizUseCaseProtocol, container: Resolver) {
        self.quizUseCase = quizUseCase
        self.container = container

        test()
    }

    private func test() {
        let solving = SolvingQuizUseCase(quizRepository: container.resolve())

        Task {
            do {
                print(try await solving.startQuiz(with: QuizStartRequestModel(id: 1)))
            } catch let err as RequestError {
                print(err)
            }
        }
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

}

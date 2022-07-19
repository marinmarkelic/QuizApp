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
        categories = CategoryType.allCases.map {
            Category(type: $0, color: $0 == type ? findColor(for: type) : .white)
        }

        Task {
            do {
                let quizzes = try await quizUseCase.fetchQuizes(for: type)
                var responseQuizes: [Quiz] = []

                for quiz in quizzes {
                    responseQuizes.append(Quiz(quiz))
                }

                self.quizzes = responseQuizes
            } catch _ {

            }
        }
    }

    private func findColor(for type: CategoryType) -> UIColor {
        switch type {
        case .sport:
            return .sportColor
        case .politics:
            return .politicsColor
        case .youtube:
            return .youtubeColor
        case .animals:
            return .animalsColor
        }
    }

    @MainActor
    func loadCategories() {
        categories = CategoryType.allCases.map {
            Category(type: $0)
        }

        changeCategory(for: categories[0].type)
    }

}

struct Quiz {

    let id: Int
    let name: String
    let description: String
    var category: Category //
    let difficulty: Difficulty
    let imageUrl: String
    let numberOfQuestions: Int

}

extension Quiz {

    init(_ quiz: QuizModel) {
        id = quiz.id
        name = quiz.name
        description = quiz.description
        category = Category(type: .youtube)
        difficulty = quiz.difficulty
        imageUrl = quiz.imageUrl
        numberOfQuestions = quiz.numberOfQuestions
    }

}

extension QuizModel {

    init(_ quiz: Quiz) {
        id = quiz.id
        name = quiz.name
        description = quiz.description
        category = CategoryModel(name: quiz.category.name, color: quiz.category.color)
        difficulty = quiz.difficulty
        imageUrl = quiz.imageUrl
        numberOfQuestions = quiz.numberOfQuestions
    }

}

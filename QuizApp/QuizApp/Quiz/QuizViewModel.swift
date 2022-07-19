import Combine
import UIKit

class QuizViewModel {

    @Published var quizzes: [Quiz] = []
    @Published var categories: [Category] = []

    func changeCategory(for type: CategoryType) {
        categories = CategoryType.allCases.map {
            Category(type: $0, color: type == $0 ? findColor(for: $0) : .white)
        }

        changeQuiz(for: type)
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

    private func changeQuiz(for type: CategoryType) {
        switch type {
        case .sport:
            quizzes = sportQuizzes
        case .politics:
            quizzes = politicsQuizzes
        case .youtube:
            quizzes = youtubeQuizzes
        case .animals:
            quizzes = animalsQuizzes
        }
    }

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
    var category: Category
    let difficulty: Difficulty
    let imageUrl: String
    let numberOfQuestions: Int

}

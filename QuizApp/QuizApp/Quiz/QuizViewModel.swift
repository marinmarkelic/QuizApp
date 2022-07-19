import Combine
import UIKit

class QuizViewModel {

    @Published var quizes: [Quiz] = []
    @Published var categories: [Category] = []

    func change(category: Category) {
        resetCategoriesColors()

        let newCategory = changeQuiz(categoryName: category.name)

        for index in (0..<categories.count) {
            if categories[index].name == category.name {
                categories[index] = newCategory
            }
        }

        for index in (0..<quizes.count) {
            quizes[index].category = newCategory
        }
    }

    private func changeQuiz(categoryName: CategoryName) -> Category {
        let color: UIColor

        switch categoryName {
        case .sport:
            quizes = sportQuizes
            color = .sportColor
        case .politics:
            quizes = politicsQuizes
            color = .politicsColor
        case .youtube:
            quizes = youtubeQuizes
            color = .youtubeColor
        case .animals:
            quizes = animalsQuizes
            color = .animalsColor
        }

        let category = Category(name: categoryName, color: color)

        return category
    }

    private func resetCategoriesColors() {
        for index in (0..<categories.count) {
            categories[index] = Category(name: categories[index].name)
        }
    }

    private func getCategory(for name: CategoryName) -> Category {
        for index in (0..<categories.count)
        where categories[index].name == name {
            return categories[index]
        }

        return Category(name: name)
    }

    func loadCategories() {
        categories = [
            Category(name: .sport, color: .sportColor),
            Category(name: .politics),
            Category(name: .youtube),
            Category(name: .animals)
        ]

        change(category: getCategory(for: categories[0].name))
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

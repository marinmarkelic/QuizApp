import Combine

class QuizViewModel {

    @Published var quizes: [Quiz] = []
    @Published var categories: [Category] = []

    func change(category: Category) {
        resetCategoriesColors()

        var newCategory = Category(name: category.name)
        changeQuiz(category: &newCategory)

        for index in (0..<categories.count) {
            if categories[index].name == category.name {
                categories[index] = newCategory
            }
        }

        for index in (0..<quizes.count) {
            quizes[index].category = newCategory
        }
    }

    private func changeQuiz(category: inout Category) {
        switch category.name {
        case .sport:
            quizes = sportQuizes
            category.color = .sportColor
        case .politics:
            quizes = politicsQuizes
            category.color = .politicsColor
        case .youtube:
            quizes = youtubeQuizes
            category.color = .youtubeColor
        case .animals:
            quizes = animalsQuizes
            category.color = .animalsColor
        }
    }

    private func resetCategoriesColors() {
        for index in (0..<categories.count) {
            categories[index].color = .white
        }
    }

    private func getCategory(for name: CategoryName) -> Category {
        for index in (0..<categories.count)
        where categories[index].name == name {
            return categories[index]
        }

        return(Category(name: name))
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

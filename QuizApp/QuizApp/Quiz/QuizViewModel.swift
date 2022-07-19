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
    }

    private func changeQuiz(category: inout Category) {
        switch category.name {
        case "Sport":
            quizes = sportQuizes
            category.color = .sportColor
        case "Politics":
            quizes = politicsQuizes
            category.color = .politicsColor
        case "Youtube":
            quizes = youtubeQuizes
            category.color = .youtubeColor
        case "Animals":
            quizes = animalsQuizes
            category.color = .animalsColor
        default:
            quizes = sportQuizes
            category.color = .sportColor
        }
    }

    private func resetCategoriesColors() {
        for index in (0..<categories.count) {
            categories[index].color = .white
        }
    }

    private func getCategory(for name: String) -> Category {
        for index in (0..<categories.count)
        where categories[index].name == name {
            return categories[index]
        }

        return(Category(name: name))
    }

    func loadCategories() {
        categories = [
            Category(name: "Sport", color: .sportColor),
            Category(name: "Politics"),
            Category(name: "Youtube"),
            Category(name: "Animals")
        ]

        change(category: getCategory(for: categories[0].name))
    }

}

struct Quiz {

    let id: Int
    let name: String
    let description: String
    let category: Category
    let difficulty: Difficulty
    let imageUrl: String
    let numberOfQuestions: Int

}

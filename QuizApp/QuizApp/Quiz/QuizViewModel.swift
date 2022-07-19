import Combine

class QuizViewModel {

    @Published var quizes: [Quiz] = []
    @Published var categories: [Category] = []

    func change(category: Category) {
        switch category.name {
        case "Sport":
            quizes = sportQuizes
        case "Politics":
            quizes = politicsQuizes
        case "Youtube":
            quizes = youtubeQuizes
        case "Animals":
            quizes = animalsQuizes
        default:
            quizes = sportQuizes
        }
    }

    func loadCategories() {
        categories = [
            Category(name: "Sport", color: .sportColor, isSelected: true),
            Category(name: "Politics", color: .politicsColor, isSelected: false),
            Category(name: "Youtube", color: .youtubeColor, isSelected: false),
            Category(name: "Animals", color: .animalsColor, isSelected: false)
        ]

        for category in categories
        where category.isSelected {
            change(category: category)
            break
        }

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

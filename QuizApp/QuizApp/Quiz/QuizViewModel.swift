import Combine

class QuizViewModel {

    @Published var quizes: [Quiz] = []
    @Published var categories: [Category] = []

    func change(category: Category) {
        quizes = [
            Quiz(id: 1,
                 name: "Football",
                 description: "Quiz description that can usually span over multiple lines",
                 category: category,
                 difficulty: .easy,
                 imageUrl: "",
                 numberOfQuestions: 0),
            Quiz(id: 1,
                 name: "Olympics",
                 description: "Quiz description that can usually span over multiple lines",
                 category: category,
                 difficulty: .medium,
                 imageUrl: "",
                 numberOfQuestions: 0),
            Quiz(id: 1,
                 name: "NBA",
                 description: "Quiz description that can usually span over multiple lines",
                 category: category,
                 difficulty: .hard,
                 imageUrl: "",
                 numberOfQuestions: 0)
        ]
    }

    func loadCategories() {
        categories = [
            Category(name: "Sport", color: sportColor, isSelected: true),
            Category(name: "Politics", color: politicsColor, isSelected: false),
            Category(name: "Youtube", color: youtubeColor, isSelected: false),
            Category(name: "Animals", color: animalsColor, isSelected: false)
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

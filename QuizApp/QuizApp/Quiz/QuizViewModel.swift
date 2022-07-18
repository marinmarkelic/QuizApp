import Combine

class QuizViewModel {

    @Published var quizes: [Quiz] = []

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

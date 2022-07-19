import Combine
import UIKit

class QuizViewModel {

    private let quizUseCase: QuizUseCaseProtocol

    @Published var quizes: [Quiz] = []
    @Published var categories: [Category] = []

    init(quizUseCase: QuizUseCaseProtocol) {
        self.quizUseCase = quizUseCase
    }

    @MainActor
    func change(category: Category) {
        Task {
            do {
                let quizes = try await quizUseCase.fetchQuizesFor(category: category)
                var responseQuizes: [Quiz] = []

                for quiz in quizes {
                    responseQuizes.append(Quiz(quiz))
                }

                self.quizes = responseQuizes
            } catch _ {

            }
        }
    }

    @MainActor
    func loadCategories() {
        categories = [
            Category(name: "Sport", color: sportColor, isSelected: true),
            Category(name: "Movies", color: moviesColor, isSelected: false),
            Category(name: "Music", color: musicColor, isSelected: false),
            Category(name: "Geography", color: geographyColor, isSelected: false)
        ]

        change(category: categories[0])
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

extension Quiz {

    init(_ quiz: QuizModel) {
        id = quiz.id
        name = quiz.name
        description = quiz.description
        category = Category(
            name: quiz.category.name,
            color: quiz.category.color,
            isSelected: quiz.category.name == "Sport" ? true : false)
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

struct Category {

    let name: String
    let color: UIColor
    var isSelected: Bool

}

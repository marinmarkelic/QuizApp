import UIKit

protocol QuizUseCaseProtocol {

    func fetchQuizesFor(category: Category) async throws -> [QuizModel]

}

class QuizUseCase: QuizUseCaseProtocol {

    private let userRepository: UserRepositoryProtocol

    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    func fetchQuizesFor(category: Category) async throws -> [QuizModel] {
        let quizes = try await userRepository.fetchQuizesFor(category: category.name.uppercased())
        var responseQuizes: [QuizModel] = []

        for quiz in quizes {
            responseQuizes.append(QuizModel(quiz))
        }

        return responseQuizes
    }

}

struct QuizModel {

    let id: Int
    let name: String
    let description: String
    let category: CategoryModel
    let difficulty: Difficulty
    let imageUrl: String
    let numberOfQuestions: Int

}

extension QuizModel {

    init(_ quiz: QuizRepoModel) {
        id = quiz.id
        name = quiz.name
        description = quiz.description
        category = CategoryModel(name: quiz.name)
        difficulty = Difficulty.easy
        imageUrl = quiz.imageUrl
        numberOfQuestions = quiz.numberOfQuestions
    }

}

struct CategoryModel {

    let name: String
    let color: UIColor

}

extension CategoryModel {

    init(name: String) {
        self.name = name

        switch name.lowercased() {
        case "geography":
            color = .animalsColor
        case "movies":
            color = .youtubeColor
        case "music":
            color = .politicsColor
        case "sport":
            color = .sportColor
        default:
            color = .white
        }
    }

}

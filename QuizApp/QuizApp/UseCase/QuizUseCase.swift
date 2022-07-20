import UIKit

protocol QuizUseCaseProtocol {

    func fetchQuizzesFor(category: Category) async throws -> [QuizModel]

    func fetchQuizzes(for type: CategoryType) async throws -> [QuizModel]

}

class QuizUseCase: QuizUseCaseProtocol {

    private let userRepository: UserRepositoryProtocol

    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    func fetchQuizzesFor(category: Category) async throws -> [QuizModel] {
        let quizzes = try await userRepository.fetchQuizzesFor(category: category.name.uppercased())
        var responseQuizzes: [QuizModel] = []

        for quiz in quizzes {
            responseQuizzes.append(QuizModel(quiz))
        }

        return responseQuizzes
    }

    func fetchQuizzes(for type: CategoryType) async throws -> [QuizModel] {
        let quizzes = try await userRepository.fetchQuizzesFor(category: Category(type: type).name.uppercased())
        var responseQuizzes: [QuizModel] = []

        for quiz in quizzes {
            responseQuizzes.append(QuizModel(quiz))
        }

        return responseQuizzes
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

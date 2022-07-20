import UIKit

protocol QuizUseCaseProtocol {

    func fetchQuizzes(for type: CategoryModel) async throws -> [QuizModel]

}

class QuizUseCase: QuizUseCaseProtocol {

    private let userRepository: UserRepositoryProtocol

    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    func fetchQuizzes(for type: CategoryModel) async throws -> [QuizModel] {
        let quizzes = try await userRepository.fetchQuizzes(for: CategoryRepoModel(rawValue: type.rawValue)!)
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
    let difficulty: String
    let imageUrl: String
    let numberOfQuestions: Int

}

extension QuizModel {

    init(_ quiz: QuizRepoModel) {
        id = quiz.id
        name = quiz.name
        description = quiz.description
        category = CategoryModel(rawValue: quiz.category.rawValue)!
        difficulty = quiz.difficulty
        imageUrl = quiz.imageUrl
        numberOfQuestions = quiz.numberOfQuestions
    }

}

enum CategoryModel: String {

    case sport = "SPORT"
    case movies = "MOVIES"
    case music = "MUSIC"
    case geography = "GEOGRAPHY"

}

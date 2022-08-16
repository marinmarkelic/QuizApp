import UIKit

protocol QuizUseCaseProtocol {

    func fetchQuizzes(for type: CategoryModel) async throws -> [QuizModel]

    func fetchAllQuizzes() async throws -> [QuizModel]

}

class QuizUseCase: QuizUseCaseProtocol {

    private let repository: QuizRepositoryProtocol

    init(repository: QuizRepositoryProtocol) {
        self.repository = repository
    }

    func fetchQuizzes(for type: CategoryModel) async throws -> [QuizModel] {
        let quizzes = try await repository.fetchQuizzes(
            for: CategoryRepoModel(rawValue: type.rawValue)!)
        return quizzes
            .map { QuizModel($0) }
    }

    func fetchAllQuizzes() async throws -> [QuizModel] {
        let quizzes = try await repository.fetchAllQuizzes()
        return quizzes
            .map { QuizModel($0) }
    }

}

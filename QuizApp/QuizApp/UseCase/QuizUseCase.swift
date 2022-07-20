import UIKit

protocol QuizUseCaseProtocol {

    func fetchQuizzes(for type: CategoryModel) async throws -> [QuizModel]

}

class QuizUseCase: QuizUseCaseProtocol {

    private let quizRepository: QuizRepositoryProtocol

    init(quizRepository: QuizRepositoryProtocol) {
        self.quizRepository = quizRepository
    }

    func fetchQuizzes(for type: CategoryModel) async throws -> [QuizModel] {
        let quizzes = try await quizRepository.fetchQuizzes(for: CategoryRepoModel(rawValue: type.rawValue)!)
        return quizzes
            .map { QuizModel($0) }
    }

}

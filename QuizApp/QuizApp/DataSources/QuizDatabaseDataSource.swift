import RealmSwift

protocol QuizDatabaseDataSourceProtocol {

    func fetchQuizzes() -> [QuizDatabaseModel]

    func save(quizzes: [QuizDatabaseModel])

}

class QuizDatabaseDataSource: QuizDatabaseDataSourceProtocol {

    func fetchQuizzes() -> [QuizDatabaseModel] {
        guard let realm = try? Realm() else { return [] }

        return Array(realm.objects(QuizDatabaseModel.self))
    }

    func save(quizzes: [QuizDatabaseModel]) {
        guard let realm = try? Realm() else { return }

        let savedQuizzes = realm.objects(QuizDatabaseModel.self)

        try? realm.write {
            for quiz in quizzes {
                if savedQuizzes.contains(where: {$0.id == quiz.id}) {
                    guard let savedQuiz = savedQuizzes.first(where: {$0.id == quiz.id}) else { continue }

                    savedQuiz.update(from: quiz)
                } else {
                    realm.add(quizzes)
                }
            }
        }
    }

}

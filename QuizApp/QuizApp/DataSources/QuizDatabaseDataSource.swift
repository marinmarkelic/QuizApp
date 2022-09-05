import RealmSwift

protocol QuizDatabaseDataSourceProtocol {

    func fetchQuizzes() -> [QuizDatabaseModel]

    func fetchQuizzes(for category: String) -> [QuizDatabaseModel]

    func save(quizzes: [QuizDatabaseModel])

}

class QuizDatabaseDataSource: QuizDatabaseDataSourceProtocol {

    func fetchQuizzes() -> [QuizDatabaseModel] {
        guard let realm = try? Realm() else { return [] }

        return Array(realm.objects(QuizDatabaseModel.self))
    }

    func fetchQuizzes(for category: String) -> [QuizDatabaseModel] {
        guard let realm = try? Realm() else { return [] }

        return Array(realm.objects(QuizDatabaseModel.self).where { $0.category == category })
    }

    func save(quizzes: [QuizDatabaseModel]) {
        guard let realm = try? Realm() else { return }

        try? realm.write {
            for quiz in quizzes {
                realm.add(quiz, update: .modified)
            }
        }
    }

}

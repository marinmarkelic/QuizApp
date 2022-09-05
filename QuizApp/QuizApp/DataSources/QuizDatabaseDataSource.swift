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

        return Array(realm.objects(QuizDatabaseModel.self)).filter { $0.category == category }
    }

    func save(quizzes: [QuizDatabaseModel]) {
        guard let realm = try? Realm() else { return }

        let savedQuizzes = realm.objects(QuizDatabaseModel.self)

        try? realm.write {
            for quiz in quizzes {
                if let savedQuiz = savedQuizzes.first(where: {$0.id == quiz.id}) {
                    savedQuiz.update(from: quiz)
                    continue
                }

                realm.add(quiz)
            }
        }
    }

}

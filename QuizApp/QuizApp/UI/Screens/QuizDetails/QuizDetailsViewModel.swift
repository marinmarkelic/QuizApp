import Combine

class QuizDetailsViewModel: ObservableObject {

    @Published var quiz: Quiz = .empty

    init(quiz: Quiz) {
        self.quiz = quiz
    }

    init() {}

}

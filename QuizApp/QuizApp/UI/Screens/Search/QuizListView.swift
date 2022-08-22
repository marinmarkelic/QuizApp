import SwiftUI

struct QuizListView: View {

    let quizzes: [Quiz]
    let onQuizTap: (Quiz) -> Void

    private var sections: [QuizSection] {
        var value: [QuizSection] = []

        for category in CategoryType.allCases {
            let quizzesForCategory = quizzes.filter { $0.category.type == category }
            if quizzesForCategory.isEmpty { continue }

            value.append(QuizSection(category: Category(from: category), quizzes: quizzesForCategory))
        }
        return value
    }

    init(quizzes: [Quiz], onQuizTap: @escaping (_ quiz: Quiz) -> Void = { _ in }) {
        self.quizzes = quizzes
        self.onQuizTap = onQuizTap
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(sections) { section in
                    Section(content: {
                        ForEach(section.quizzes, id: \.id) {
                            QuizListCell(quiz: $0)
                                .onQuizTap {
                                    onQuizTap($0)
                                }
                        }
                    }, header: {
                        Text(section.category.name)
                            .font(.heading4)
                            .foregroundColor(Color(uiColor: section.category.color))
                            .pushedLeft()
                            .padding(.top, 10)
                    })
                }
            }
        }
    }

    func onQuizTap(_ onQuizTap: @escaping (_ quiz: Quiz) -> Void) -> QuizListView {
        QuizListView(quizzes: quizzes, onQuizTap: onQuizTap)
    }

}

struct QuizSection: Identifiable {

    let id = UUID()
    let category: Category
    let quizzes: [Quiz]

}

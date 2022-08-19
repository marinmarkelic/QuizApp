import SwiftUI

struct QuizListView: View {

    var quizzes: [Quiz]

    var sections: [QuizSection] {
        var value: [QuizSection] = []

        for category in CategoryType.allCases {
            let quizzesForCategory = quizzes.filter { $0.category.type == category }
            if quizzesForCategory.isEmpty { continue }

            value.append(QuizSection(category: Category(from: category), quizzes: quizzesForCategory))
        }
        return value
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(sections) { section in
                    Section(content: {
                        ForEach(section.quizzes, id: \.id) {
                            QuizListCell(quiz: $0)
                        }
                    }, header: {
                        Text(section.category.name)
                            .font(.heading4)
                            .foregroundColor(Color(uiColor: section.category.color))
                            .pushedLeft()
                    })
                }
            }
        }
    }

}

struct QuizSection: Identifiable {

    let id = UUID()
    let category: Category
    let quizzes: [Quiz]

}

import SwiftUI
import LazyViewSwiftUI

struct QuizListView: View {

    @EnvironmentObject var quizStates: QuizStates

    let quizzes: [Quiz]
    let alwaysShowSections: Bool

    private var sections: [QuizSection] {
        var value: [QuizSection] = []

        for category in CategoryType.allCases {
            let quizzesForCategory = quizzes.filter { $0.category.type == category }
            if quizzesForCategory.isEmpty { continue }

            value.append(QuizSection(category: Category(from: category), quizzes: quizzesForCategory))
        }
        return value
    }

    init(quizzes: [Quiz], alwaysShowSections: Bool = true) {
        self.quizzes = quizzes
        self.alwaysShowSections = alwaysShowSections
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(sections) { section in
                    Section(content: {
                        ForEach(section.quizzes, id: \.id) { quiz in
                            NavigationLink(
                                destination: LazyView(QuizDetailsView(viewModel: QuizDetailsViewModel(quiz: quiz)))
                            ) {
                                QuizListCell(quiz: quiz)
                            }
                        }
                    }, header: {
                        let title = alwaysShowSections || sections.count > 1 ?
                        section.category.name :
                        ""

                        Text(title)
                            .font(.heading4)
                            .foregroundColor(Color(uiColor: section.category.color))
                            .maxWidth(alignment: .leading)
                            .padding(.top, 10)
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

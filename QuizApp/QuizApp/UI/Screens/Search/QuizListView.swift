import SwiftUI

struct QuizListView: View {

    var quizzes: [Quiz]

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(quizzes, id: \.id) {
                    QuizListCell(quiz: $0)
                }
            }
        }
    }

}

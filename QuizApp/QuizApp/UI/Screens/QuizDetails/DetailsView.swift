import SwiftUI
import SDWebImageSwiftUI
import Resolver
import UIPilot

struct DetailsView: View {

    @EnvironmentObject var container: Resolver
    @EnvironmentObject var quizzesPilot: UIPilot<QuizAppRoute>
    @EnvironmentObject var searchPilot: UIPilot<SearchAppRoute>
    @EnvironmentObject var appData: AppData

    let quiz: Quiz

    var body: some View {
        VStack {
            Text(quiz.name)
                .font(.heading1)
                .foregroundColor(.white)
                .padding(.vertical, 15)

            Text(quiz.description)
                .font(.subtitle1)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            WebImage(url: URL(string: quiz.imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding(.vertical, 10)
                .frame(height: 200)

            Button(action: {
                if appData.selectedTab == .quizzes {
                    quizzesPilot.push(.solving(quiz.id))
                } else if appData.selectedTab == .search {
                    searchPilot.push(.solving(quiz.id))
                }
            }, label: {
                Text("Start Quiz")
                    .foregroundColor(.purpleText)
                    .font(.heading6)
                    .maxWidth()
            })
            .padding()
            .background(.white)
            .cornerRadius(25)
        }
        .maxWidth()
        .padding()
        .background(.white.opacity(0.3))
        .cornerRadius(10)
        .navigationBarTitle("PopQuiz")
    }

}

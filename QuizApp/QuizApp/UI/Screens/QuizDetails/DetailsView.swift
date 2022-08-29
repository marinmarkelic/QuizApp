import SwiftUI
import SDWebImageSwiftUI
import LazyViewSwiftUI
import Resolver

struct DetailsView: View {

    @EnvironmentObject var container: Resolver

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

            NavigationLink(
                destination:
                    LazyView(SolvingQuizView(viewModel: container.resolve(SolvingQuizViewModel.self, args: quiz.id)))
            ) {
                Button(action: { }, label: {
                    Text("Start Quiz")
                        .foregroundColor(.purpleText)
                        .font(.heading6)
                        .maxWidth()
                })
                .padding()
                .background(.white)
                .cornerRadius(25)
                .disabled(true)
            }
        }
        .maxWidth()
        .padding()
        .background(.white.opacity(0.3))
        .cornerRadius(10)
        .navigationBarTitle("PopQuiz")
    }

}

import SwiftUI
import UIPilot
import Resolver

struct QuizSelectionView: View {

    @EnvironmentObject var container: Resolver

    @StateObject var quizzesPilot = UIPilot(initial: QuizAppRoute.all)

    var body: some View {
        VStack {
            UIPilotHost(quizzesPilot) { route in
                AnyView(makeScreen(route))
            }
        }
    }

    @ViewBuilder
    private func makeScreen(_ route: QuizAppRoute) -> some View {
        switch route {
        case .all:
            QuizView(viewModel: container.resolve())
        case .details(let quiz):
            QuizDetailsView(viewModel: container.resolve(args: quiz))
        case .solving(let quizId):
            SolvingQuizView(viewModel: container.resolve(args: quizId))
        case .finished(let results):
            QuizResultView(viewModel: container.resolve(args: results))
        }
    }

}

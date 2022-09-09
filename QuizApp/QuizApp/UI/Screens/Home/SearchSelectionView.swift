import SwiftUI
import UIPilot
import Resolver

struct SearchSelectionView: View {

    @EnvironmentObject var container: Resolver

    @StateObject var pilot = UIPilot(initial: SearchAppRoute.search)

    var body: some View {
        VStack {
            UIPilotHost(pilot) { route in
                AnyView(makeScreen(route))
            }
        }
    }

    @ViewBuilder
    private func makeScreen(_ route: SearchAppRoute) -> some View {
        switch route {
        case .search:
            SearchView(viewModel: container.resolve())
        case .details(let quiz):
            QuizDetailsView(viewModel: container.resolve(args: quiz))
                .addChevronBackButton(pilot)
        case .leaderboard(let id):
            LeaderboardView(viewModel: container.resolve(args: id))
                .addXBackButton(pilot)
        case .solving(let quizId):
            SolvingQuizView(viewModel: container.resolve(args: quizId))
                .addChevronBackButton(pilot)
        case .finished(let results):
            QuizResultView(viewModel: container.resolve(args: results))
        }
    }

}

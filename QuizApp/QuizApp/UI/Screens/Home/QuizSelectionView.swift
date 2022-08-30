import SwiftUI
import UIPilot
import Resolver

struct QuizSelectionView: View {

    @EnvironmentObject var container: Resolver

    @StateObject var quizzesPilot = UIPilot(initial: QuizAppRoute.all)

    var body: some View {
        VStack {
            UIPilotHost(quizzesPilot) { route in
                switch route {
                case .all: return AnyView(QuizView(viewModel: container.resolve()))
                case .details(let quiz): return AnyView(QuizDetailsView(viewModel: container.resolve(args: quiz)))
                case .solving(let quizId): return AnyView(SolvingQuizView(viewModel: container.resolve(args: quizId)))
                case .finished(let results): return AnyView(QuizResultView(viewModel: container.resolve(args: results)))
                }
            }
        }
    }

}

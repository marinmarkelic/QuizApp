import UIKit

class SolvingQuizViewController: UIViewController {

    private var solvingQuizViewModel: SolvingQuizViewModel!
    private var appRouter: AppRouterProtocol!

    init(solvingQuizViewModel: SolvingQuizViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.solvingQuizViewModel = solvingQuizViewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

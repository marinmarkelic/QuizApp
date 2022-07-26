import UIKit

class SolvingQuizViewController: UIViewController {

    private var solvingQuizViewModel: SolvingQuizViewModel!
    private var appRouter: AppRouterProtocol!

    init(solvingQuizViewModel: SolvingQuizViewModel, appRouter: AppRouterProtocol) {
        super.init(nibName: nil, bundle: nil)

        self.solvingQuizViewModel = solvingQuizViewModel
        self.appRouter = appRouter

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        solvingQuizViewModel.startQuiz()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

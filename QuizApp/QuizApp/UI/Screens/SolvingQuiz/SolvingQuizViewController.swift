import UIKit

class SolvingQuizViewController: UIViewController {

    private var id: Int?

    private var solvingQuizViewModel: SolvingQuizViewModel!
    private var appRouter: AppRouterProtocol!

    init(solvingQuizViewModel: SolvingQuizViewModel, appRouter: AppRouterProtocol) {
        super.init(nibName: nil, bundle: nil)

        self.solvingQuizViewModel = solvingQuizViewModel
        self.appRouter = appRouter
    }

    func set(id: Int) {
        self.id = id
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let id = id else { return }

        solvingQuizViewModel.startQuiz(with: id)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

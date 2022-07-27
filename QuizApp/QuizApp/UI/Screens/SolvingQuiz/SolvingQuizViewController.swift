import UIKit

class SolvingQuizViewController: UIViewController {

    private var viewModel: SolvingQuizViewModel!

    init(viewModel: SolvingQuizViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

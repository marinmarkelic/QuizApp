import UIKit

class QuizNavigationController: UINavigationController {

    private var quizViewController: QuizViewController!

    init(quizViewController: QuizViewController) {
        super.init(nibName: nil, bundle: nil)

        viewControllers = [quizViewController]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

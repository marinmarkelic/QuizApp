import Combine
import UIKit

class SolvingQuizViewController: UIViewController {

    private var quiz: QuizStartResponse!

    private var solvingQuizViewModel: SolvingQuizViewModel!
    private var appRouter: AppRouterProtocol!

    private var gradientView: GradientView!
    private var mainView: UIView!

    private var cancellables = Set<AnyCancellable>()

    init(solvingQuizViewModel: SolvingQuizViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.solvingQuizViewModel = solvingQuizViewModel

        createViews()
        styleViews()
        defineLayoutForViews()
        bindViewModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bindViewModel() {
        solvingQuizViewModel
            .$quiz
            .sink { [weak self] quiz in
                print(quiz)
                self?.quiz = quiz
            }
            .store(in: &cancellables)
    }

}

extension SolvingQuizViewController: ConstructViewsProtocol {

    func createViews() {
        gradientView = GradientView()
        view.addSubview(gradientView)

        mainView = UIView()
        gradientView.addSubview(mainView)
    }

    func styleViews() {

    }

    func defineLayoutForViews() {
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

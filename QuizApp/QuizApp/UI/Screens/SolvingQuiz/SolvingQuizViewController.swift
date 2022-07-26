import Combine
import UIKit

class SolvingQuizViewController: UIViewController {

    private var quiz: QuizStartResponse!

    private var solvingQuizViewModel: SolvingQuizViewModel!
    private var appRouter: AppRouterProtocol!

    private var gradientView: GradientView!
    private var mainView: UIView!

    private var progressView: ProgressView!

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
                self?.progressView.set(numberOfQuestions: quiz.questions.count)
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

        progressView = ProgressView()
        mainView.addSubview(progressView)
    }

    func styleViews() {

    }

    func defineLayoutForViews() {
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        progressView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(20)
        }
    }

}

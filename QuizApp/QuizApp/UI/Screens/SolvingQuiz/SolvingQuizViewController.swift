import Combine
import UIKit

class SolvingQuizViewController: UIViewController {

    private var quiz: QuizStartResponse!

    private var solvingQuizViewModel: SolvingQuizViewModel!
    private var appRouter: AppRouterProtocol!

    private var gradientView: GradientView!
    private var mainView: UIView!

    private var progressView: ProgressView!
    private var questionsView: QuestionsView!

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
                if quiz.questions.isEmpty { return }

                self?.quiz = quiz
                self?.progressView.set(numberOfQuestions: quiz.questions.count)
                self?.questionsView.set(questions: quiz.questions)
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

        questionsView = QuestionsView()
        mainView.addSubview(questionsView)
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

        questionsView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }

}

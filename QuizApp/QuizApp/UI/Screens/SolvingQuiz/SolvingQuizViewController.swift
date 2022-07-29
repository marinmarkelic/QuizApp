import Combine
import UIKit

class SolvingQuizViewController: UIViewController {

    private let viewModel: SolvingQuizViewModel

    private var isPortrait: Bool!

    private var gradientView: GradientView!
    private var mainView: UIView!

    private var errorView: ErrorView!

    private var progressView: ProgressView!
    private var questionsView: QuestionsView!

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: SolvingQuizViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        createViews()
        styleViews()
        defineLayoutForViews()
        bindViewModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        isPortrait = UIDevice.current.orientation.isPortrait
        viewModel.startQuiz()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // This is used because we only want redraw() to be called on rotation and not when
        // collectionView.scrollToItem() is called.
        if isPortrait != UIDevice.current.orientation.isPortrait {
            isPortrait = UIDevice.current.orientation.isPortrait
            questionsView.redraw(with: viewModel.currentQuestionIndex)
        }
    }

    private func bindViewModel() {
        viewModel
            .$quiz
            .removeDuplicates()
            .sink { [weak self] quiz in
                self?.questionsView.set(questions: quiz.questions)
            }
            .store(in: &cancellables)

        viewModel
            .$progressColors
            .removeDuplicates()
            .sink { [weak self] colors in
                self?.progressView.set(colors: colors)
            }
            .store(in: &cancellables)

        viewModel
            .$currentQuestionIndex
            .removeDuplicates()
            .sink { [weak self] questionIndex in
                guard let self = self else { return }

                let scrollDelayInMillis = 300

                self.progressView.set(current: questionIndex + 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(scrollDelayInMillis)) {
                    self.questionsView.scrollToQuestion(at: questionIndex)
                }
            }
            .store(in: &cancellables)

        viewModel
            .$errorMessage
            .removeDuplicates()
            .sink { [weak self] errorMessage in
                guard let self = self else { return }

                self.errorView.isHidden = errorMessage.isEmpty
                self.progressView.isHidden = !errorMessage.isEmpty
                self.questionsView.isHidden = !errorMessage.isEmpty

                self.errorView.set(description: errorMessage)
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

        errorView = ErrorView()
        mainView.addSubview(errorView)

        progressView = ProgressView()
        mainView.addSubview(progressView)

        questionsView = QuestionsView()
        mainView.addSubview(questionsView)
    }

    func styleViews() {
        let titleView = UILabel()
        titleView.text = "PopQuiz"
        titleView.textColor = .white
        titleView.font = UIFont(descriptor: UIFontDescriptor(name: "SourceSansPro-Regular", size: 24), size: 24)
        navigationItem.titleView = titleView

        let image = UIImage(systemName: "chevron.left")?.withTintColor(.white)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image,
            style: .done,
            target: self,
            action: #selector(pressedBack))
        navigationItem.leftBarButtonItem?.tintColor = .white

        questionsView.delegate = self
    }

    @objc
    private func pressedBack() {
        viewModel.goBack()
    }

    func defineLayoutForViews() {
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        errorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        progressView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(20)
        }

        questionsView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }

}

extension SolvingQuizViewController: QuestionsViewDelegate {

    func selectedAnswer(with id: Int) {
        viewModel.selectedAnswer(with: id)
    }

}

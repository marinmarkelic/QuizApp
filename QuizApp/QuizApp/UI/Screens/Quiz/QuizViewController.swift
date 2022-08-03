import UIKit
import Combine

class QuizViewController: UIViewController {

    private var viewModel: QuizViewModel!

    private var cancellables = Set<AnyCancellable>()

    private var gradientView: GradientView!
    private var mainView: UIView!

    private var quizContainer: UIView!

    private var categorySlider: CategorySlider!
    private var quizView: QuizView!

    private var noQuizErrorLabel: UILabel!
    private var errorView: ErrorView!

    init(viewModel: QuizViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel

        styleTabBarItem()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
        bindViewModel()

        viewModel.loadCategories()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        categorySlider.redraw()
        quizView.redraw()
    }

    func styleTabBarItem() {
        let config = UIImage.SymbolConfiguration(scale: .medium)

        tabBarItem = UITabBarItem(
            title: "Quiz",
            image: UIImage(systemName: "rectangle.3.offgrid", withConfiguration: config),
            selectedImage: UIImage(systemName: "rectangle.3.offgrid.fill", withConfiguration: config))
    }

    func bindViewModel() {
        viewModel
            .$quizzes
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] quizzes in
                guard let self = self else { return }

                self.quizView.reload(with: quizzes)
                self.noQuizErrorLabel.isHidden = !quizzes.isEmpty
            }
            .store(in: &cancellables)

        viewModel
            .$categories
            .removeDuplicates()
            .sink { [weak self] categories in
                self?.categorySlider.reload(with: categories)
            }
            .store(in: &cancellables)

        viewModel
            .$errorMessage
            .removeDuplicates()
            .sink { [weak self] errorMessage in
                guard let self = self else { return }

                self.errorView.isHidden = errorMessage.isEmpty
                self.errorView.set(description: errorMessage)
            }
            .store(in: &cancellables)
    }

}

extension QuizViewController: QuizViewDelegate {

    func selected(quiz: Quiz) {
        viewModel.showQuizDetails(with: quiz)
    }

}

extension QuizViewController: ConstructViewsProtocol {

    func createViews() {
        gradientView = GradientView()
        view.addSubview(gradientView)

        mainView = UIView()
        gradientView.addSubview(mainView)

        quizContainer = UIView()
        mainView.addSubview(quizContainer)

        categorySlider = CategorySlider()
        quizContainer.addSubview(categorySlider)

        quizView = QuizView()
        quizContainer.addSubview(quizView)

        noQuizErrorLabel = UILabel()
        mainView.addSubview(noQuizErrorLabel)

        errorView = ErrorView()
        mainView.addSubview(errorView)
    }

    func styleViews() {
        let titleView = UILabel()
        titleView.text = "PopQuiz"
        titleView.textColor = .white
        titleView.font = .heading3
        tabBarController?.navigationItem.titleView = titleView

        categorySlider.delegate = self
        quizView.delegate = self

        noQuizErrorLabel.text = "There are no quizzes for this category"
        noQuizErrorLabel.font = .heading4
        noQuizErrorLabel.textColor = .white
        noQuizErrorLabel.numberOfLines = 0
        noQuizErrorLabel.textAlignment = .center
        noQuizErrorLabel.isHidden = true
    }

    func defineLayoutForViews() {
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        quizContainer.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }

        categorySlider.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }

        quizView.snp.makeConstraints {
            $0.top.equalTo(categorySlider.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        noQuizErrorLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        errorView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(50)
        }
    }

}

extension QuizViewController: CategorySliderDelegate {

    func selectedCategory(_ categorySlider: CategorySlider, category: Category) {
        viewModel.changeCategory(for: category.type)
    }

}

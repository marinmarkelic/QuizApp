import UIKit
import Combine

class QuizViewController: UIViewController {

    private var quizViewModel: QuizViewModel!

    private var cancellables = Set<AnyCancellable>()

    private var gradientView: GradientView!

    private var mainView: UIView!

    private var titleView: UILabel!

    private var quizContainer: UIView!

    private var categorySlider: CategorySlider!
    private var quizView: QuizView!

    private var errorLabel: UILabel!

    init(quizUseCase: QuizUseCaseProtocol) {
        super.init(nibName: nil, bundle: nil)

        self.quizViewModel = QuizViewModel(quizUseCase: quizUseCase)

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

        quizViewModel.loadCategories()
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
        quizViewModel
            .$quizzes
            .removeDuplicates()
            .sink { [weak self] quizzes in
                guard let self = self else { return }

                self.quizView.reload(with: quizzes)
                self.errorLabel.isHidden = quizzes.count != 0
            }
            .store(in: &cancellables)

        quizViewModel
            .$categories
            .removeDuplicates()
            .sink { [weak self] categories in
                self?.categorySlider.reload(with: categories)
            }
            .store(in: &cancellables)
    }

}

extension QuizViewController: ConstructViewsProtocol {

    func createViews() {
        gradientView = GradientView()
        view.addSubview(gradientView)

        mainView = UIView()
        gradientView.addSubview(mainView)

        titleView = UILabel()

        quizContainer = UIView()
        mainView.addSubview(quizContainer)

        categorySlider = CategorySlider()
        quizContainer.addSubview(categorySlider)

        quizView = QuizView()
        quizContainer.addSubview(quizView)

        errorLabel = UILabel()
        mainView.addSubview(errorLabel)
    }

    func styleViews() {
        titleView.text = "PopQuiz"
        titleView.textColor = .white
        titleView.font = UIFont(descriptor: UIFontDescriptor(name: "SourceSansPro-Regular", size: 24), size: 24)
        tabBarController?.navigationItem.titleView = titleView

        categorySlider.delegate = self

        errorLabel.text = "There are no quizzes for this category"
        errorLabel.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        errorLabel.textColor = .white
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
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

        errorLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}

extension QuizViewController: CategorySliderDelegate {

    func selectedCategory(_ categorySlider: CategorySlider, category: Category) {
        quizViewModel.changeCategory(for: category.type)
    }

}

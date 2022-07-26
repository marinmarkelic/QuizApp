import UIKit

class QuizDetailsViewController: UIViewController {

    private var id: Int?

    private var appRouter: AppRouterProtocol!

    private var solvingQuizViewModel: SolvingQuizViewModel!

    private var gradientView: GradientView!

    private var mainView: UIView!

    private var detailsView: DetailsView!

    init(appRouter: AppRouterProtocol, solvingQuizViewModel: SolvingQuizViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.appRouter = appRouter
        self.solvingQuizViewModel = solvingQuizViewModel

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(quiz: Quiz) {
        id = quiz.id

        detailsView.set(quiz: quiz)
    }

}

extension QuizDetailsViewController: ConstructViewsProtocol {

    func createViews() {
        gradientView = GradientView()
        view.addSubview(gradientView)

        mainView = UIView()
        gradientView.addSubview(mainView)

        detailsView = DetailsView()
        mainView.addSubview(detailsView)
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

        detailsView.delegate = self
    }

    @objc
    private func pressedBack() {
        navigationController?.popViewController(animated: true)
    }

    func defineLayoutForViews() {
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        detailsView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.center.equalToSuperview()
        }
    }

}

extension QuizDetailsViewController: DetailsViewDelegate {

    func startQuiz() {
        guard let id = id else { return }

        solvingQuizViewModel.startQuiz(with: id)
        appRouter.showQuiz(with: id)
    }

}

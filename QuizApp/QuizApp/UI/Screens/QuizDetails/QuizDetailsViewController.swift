import UIKit

class QuizDetailsViewController: UIViewController {

    private var quiz: Quiz!

    private var appRouter: AppRouterProtocol!

    private var quizDetailsViewModel: QuizDetailsViewModel!

    private var gradientView: GradientView!

    private var mainView: UIView!

    private var detailsView: DetailsView!

    init(appRouter: AppRouterProtocol, quizDetailsViewModel: QuizDetailsViewModel, quiz: Quiz) {
        super.init(nibName: nil, bundle: nil)

        self.appRouter = appRouter
        self.quizDetailsViewModel = quizDetailsViewModel
        self.quiz = quiz

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

        detailsView.set(quiz: quiz)
        detailsView.delegate = self
    }

    @objc
    private func pressedBack() {
        appRouter.goBack()
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
        guard let quiz = quiz else { return }

        quizDetailsViewModel.startQuiz(with: quiz.id)
    }

}

import Combine
import UIKit

class QuizDetailsViewController: UIViewController {

    private var viewModel: QuizDetailsViewModel!

    private var gradientView: GradientView!

    private var mainView: UIView!

    private var leaderboardButton: UIButton!

    private var detailsView: DetailsView!

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: QuizDetailsViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel

        createViews()
        styleViews()
        defineLayoutForViews()
        bindModels()
        bindViewModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        remakeLayout()
        detailsView.remakeLayout()
    }

    private func bindModels() {
        leaderboardButton
            .tap
            .sink { [weak self] _ in
                self?.viewModel.showLeaderboard()
            }
            .store(in: &cancellables)

        detailsView
            .onStartPress
            .sink { [weak self] _ in
                self?.viewModel.startQuiz()
            }
            .store(in: &cancellables)

        navigationItem
            .leftBarButtonItem?
            .tap
            .sink { [weak self] _ in
                self?.viewModel.goBack()
            }
            .store(in: &cancellables)
    }

    private func bindViewModel() {
        viewModel
            .$quiz
            .sink { [weak self] quiz in
                self?.detailsView.set(quiz: quiz)
            }
            .store(in: &cancellables)
    }

    private func remakeLayout() {
        if UIDevice.current.orientation.isLandscape {
            leaderboardButton.snp.remakeConstraints {
                $0.top.greaterThanOrEqualToSuperview().offset(5)
                $0.bottom.equalTo(detailsView.snp.top).offset(-15)
                $0.trailing.equalToSuperview().inset(20)
            }

            detailsView.snp.remakeConstraints {
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.center.equalToSuperview()
            }
        } else {
            leaderboardButton.snp.remakeConstraints {
                $0.top.greaterThanOrEqualToSuperview().offset(5)
                $0.bottom.equalTo(detailsView.snp.top).offset(-5)
                $0.trailing.equalToSuperview().inset(20)
            }

            detailsView.snp.remakeConstraints {
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.center.equalToSuperview()
            }
        }
    }

}

extension QuizDetailsViewController: ConstructViewsProtocol {

    func createViews() {
        gradientView = GradientView()
        view.addSubview(gradientView)

        mainView = UIView()
        gradientView.addSubview(mainView)

        leaderboardButton = UIButton()
        mainView.addSubview(leaderboardButton)

        detailsView = DetailsView()
        mainView.addSubview(detailsView)
    }

    func styleViews() {
        let titleView = UILabel()
        titleView.text = "PopQuiz"
        titleView.textColor = .white
        titleView.font = .heading3
        navigationItem.titleView = titleView

        let image = UIImage(systemName: "chevron.left")?.withTintColor(.white)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image,
            style: .done,
            target: self,
            action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .white

        leaderboardButton.setTitle("Leaderboard", for: .normal)
        leaderboardButton.titleLabel?.font = .heading5
    }

    func defineLayoutForViews() {
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        remakeLayout()
    }

}

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

        leaderboardButton.setTitle("Leaderboard", for: .normal)
        leaderboardButton.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 18)
        leaderboardButton.addTarget(self, action: #selector(pressedLeaderboard), for: .touchUpInside)
    }

    @objc
    private func pressedLeaderboard() {
        viewModel.showLeaderboard()
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

        leaderboardButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview().offset(5)
            $0.bottom.equalTo(detailsView.snp.top).offset(-5)
            $0.trailing.equalToSuperview().inset(20)
        }

        detailsView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.center.equalToSuperview()
        }
    }

}

extension QuizDetailsViewController: DetailsViewDelegate {

    func startQuiz() {
        viewModel.startQuiz()
    }

}

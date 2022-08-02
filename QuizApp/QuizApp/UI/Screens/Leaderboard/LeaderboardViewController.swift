import Combine
import UIKit

class LeaderboardViewController: UIViewController {

    private let viewModel: LeaderboardViewModel

    private var leaderboard: Leaderboard = .empty

    private var gradientView: GradientView!
    private var mainView: UIView!

    private var playerLabel: UILabel!
    private var pointsLabel: UILabel!

    private var tableView: UITableView!

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: LeaderboardViewModel) {
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
        viewModel.fetchLeaderboard()
    }

    private func bindViewModel() {
        viewModel
            .$leaderboard
            .sink { [weak self] leaderboard in
                guard let self = self else { return }

                self.leaderboard = leaderboard
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

}

extension LeaderboardViewController: ConstructViewsProtocol {

    func createViews() {
        gradientView = GradientView()
        view.addSubview(gradientView)

        mainView = UIView()
        gradientView.addSubview(mainView)

        playerLabel = UILabel()
        mainView.addSubview(playerLabel)

        pointsLabel = UILabel()
        mainView.addSubview(pointsLabel)

        tableView = UITableView()
        mainView.addSubview(tableView)
    }

    func styleViews() {
        let titleView = UILabel()
        titleView.text = "Leaderboard"
        titleView.textColor = .white
        titleView.font = UIFont(name: "SourceSansPro-Regular", size: 24)
        navigationItem.titleView = titleView

        navigationItem.leftBarButtonItem = UIBarButtonItem()

        let image = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        let closeButton = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(pressedClose))
        closeButton.tintColor = .white
        navigationItem.rightBarButtonItem = closeButton

        playerLabel.text = "Player"
        playerLabel.textColor = .white
        playerLabel.font = UIFont(name: "SourceSansPro-Regular", size: 16)

        pointsLabel.text = "Points"
        pointsLabel.textColor = .white
        pointsLabel.font = UIFont(name: "SourceSansPro-Regular", size: 16)

        let border = UIView()
        let onePixel = 1 / UIScreen.main.scale

        border.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: onePixel)
        border.backgroundColor = .white
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]

        tableView.addSubview(border)
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.register(LeaderboardCell.self, forCellReuseIdentifier: LeaderboardCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.separatorColor = .white
        tableView.separatorInset = .zero
    }

    @objc
    private func pressedClose() {
        viewModel.pressedClose()
    }

    func defineLayoutForViews() {
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        playerLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(20)
        }

        pointsLabel.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(playerLabel.snp.trailing).offset(5)
            $0.trailing.top.equalToSuperview().inset(20)
            $0.bottom.equalTo(playerLabel)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(playerLabel.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

}

extension LeaderboardViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leaderboard.leaderboardPoints.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: LeaderboardCell.reuseIdentifier,
                for: indexPath) as? LeaderboardCell
        else { return LeaderboardCell() }

        let points = leaderboard.leaderboardPoints[indexPath.row]

        cell.set(rank: indexPath.row + 1, name: points.name, score: points.points)

        return cell
    }

}

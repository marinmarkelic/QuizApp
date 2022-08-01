import UIKit

class LeaderboardViewController: UIViewController {

    private let viewModel: LeaderboardViewModel

    private var gradientView: GradientView!
    private var mainView: UIView!

    private var playerLabel: UILabel!
    private var pointsLabel: UILabel!

    private var tableView: UITableView!

    init(viewModel: LeaderboardViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchLeaderboard()
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
        playerLabel.text = "Player"

        pointsLabel.text = "Points"

        tableView.register(LeaderboardCell.self, forCellReuseIdentifier: LeaderboardCell.reuseIdentifier)
        tableView.dataSource = self
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
            $0.trailing.top.equalToSuperview().inset(20)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(playerLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

}

extension LeaderboardViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: LeaderboardCell.reuseIdentifier, for: indexPath) as? LeaderboardCell
        else {
            return LeaderboardCell()
        }


    }

}

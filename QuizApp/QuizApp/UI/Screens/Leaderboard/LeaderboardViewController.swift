import UIKit

class LeaderboardViewController: UIViewController {

    private let viewModel: LeaderboardViewModel

    init(viewModel: LeaderboardViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchLeaderboard()
    }

}

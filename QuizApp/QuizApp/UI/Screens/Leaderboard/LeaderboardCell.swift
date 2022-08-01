import UIKit

class LeaderboardCell: UITableViewCell {

    static let reuseIdentifier = String(describing: LeaderboardCell.self)

    private var rankLabel: UILabel!
    private var nameLabel: UILabel!
    private var scoreLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LeaderboardCell: ConstructViewsProtocol {
    func createViews() {
        rankLabel = UILabel()
        addSubview(rankLabel)

        nameLabel = UILabel()
        addSubview(nameLabel)

        scoreLabel = UILabel()
        addSubview(scoreLabel)
    }

    func styleViews() {

    }

    func defineLayoutForViews() {
        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(10)
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(rankLabel).offset(5)
            $0.top.bottom.equalTo(rankLabel)
        }

        scoreLabel.snp.makeConstraints {
            $0.leading.lessThanOrEqualTo(nameLabel)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalTo(rankLabel)
        }
    }

}

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

    func set(rank: Int, name: String, score: Int) {
        rankLabel.text = "\(String(rank))."
        nameLabel.text = name
        scoreLabel.text = String(score)
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
        backgroundColor = .clear

        rankLabel.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        rankLabel.textAlignment = .center

        nameLabel.font = UIFont(name: "SourceSansPro-Regular", size: 20)

        scoreLabel.font = UIFont(name: "SourceSansPro-Bold", size: 20)
    }

    func defineLayoutForViews() {
        rankLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(10)
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.trailing).offset(5)
            $0.top.bottom.equalTo(rankLabel)
        }

        scoreLabel.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(nameLabel)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalTo(rankLabel)
        }
    }

}

import UIKit

class QuizCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: QuizCell.self)

    private var image: UIImageView!
    private var difficultyView: DifficultyView!

    private var title: UILabel!
    private var desc: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(quiz: Quiz) {
        title.text = quiz.name
        desc.text = quiz.description

        difficultyView.set(difficulty: quiz.difficulty, color: quiz.category.color)
    }

}

extension QuizCell: ConstructViewsProtocol {

    func createViews() {
        let icon = UIImage(systemName: "questionmark.square")

        image = UIImageView(image: icon)
        addSubview(image)

        difficultyView = DifficultyView()
        addSubview(difficultyView)

        title = UILabel()
        addSubview(title)

        desc = UILabel()
        addSubview(desc)
    }

    func styleViews() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = .white.withAlphaComponent(0.3)

        title.textColor = .white
        title.font = UIFont(name: "SourceSansPro-Bold", size: 24)

        desc.textColor = .white
        desc.font = UIFont(name: "SourceSansPro-Bold", size: 14)
        desc.numberOfLines = 0
    }

    func defineLayoutForViews() {
        image.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(100)
        }

        difficultyView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }

        title.snp.makeConstraints {
            $0.leading.equalTo(image.snp.trailing).offset(20)
            $0.top.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().inset(20)
        }

        desc.snp.makeConstraints {
            $0.leading.equalTo(image.snp.trailing).offset(20)
            $0.top.equalTo(title.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().inset(20)
        }
    }

}

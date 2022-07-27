import UIKit

class QuestionCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: QuestionCell.self)

    private var answers: [Answer] = []

    private var label: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(title: String, answers: [Answer]) {
        label.text = title
        self.answers = answers
    }

}

extension QuestionCell: ConstructViewsProtocol {

    func createViews() {
        label = UILabel()
        addSubview(label)
    }

    func styleViews() {
        label.font = UIFont(name: "SourceSansPro-Bold", size: 24)
        label.textColor = .white
        label.numberOfLines = 0
    }

    func defineLayoutForViews() {
        label.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }

}

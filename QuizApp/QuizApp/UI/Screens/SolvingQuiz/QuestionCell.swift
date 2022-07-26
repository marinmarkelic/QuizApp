import UIKit

class QuestionCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: QuestionCell.self)

    private var title: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension QuestionCell: ConstructViewsProtocol {

    func createViews() {
        title = UILabel()
        addSubview(title)
    }

    func styleViews() {
        backgroundColor = .yellow

        title.text = "yeet"
    }

    func defineLayoutForViews() {
        title.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
    }

}

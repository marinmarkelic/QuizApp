import UIKit

class QuizHeader: UICollectionViewCell {

    static let reuseIdentifier = String(describing: QuizHeader.self)

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

    func set(title: String, color: UIColor) {
        label.text = title
        label.textColor = color
    }

}

extension QuizHeader: ConstructViewsProtocol {

    func createViews() {
        label = UILabel()
        addSubview(label)
    }

    func styleViews() {
        label.font = UIFont(name: "SourceSansPro-Bold", size: 20)
    }

    func defineLayoutForViews() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

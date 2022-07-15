import UIKit

class CategoryCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: CategorySlider.self)

    private var label: UILabel!

    private var color: UIColor!

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
        self.color = color
    }

    func changeColor() {
        if label.textColor == .white {
            label.textColor = color
        } else {
            label.textColor = .white
        }
    }

    func resetColor() {
        label.textColor = .white
    }

}

extension CategoryCell: ConstructViewsProtocol {

    func createViews() {
        label = UILabel()
        addSubview(label)
    }

    func styleViews() {
        label.textColor = .white
    }

    func defineLayoutForViews() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

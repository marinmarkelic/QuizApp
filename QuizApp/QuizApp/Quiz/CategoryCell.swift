import UIKit

class CategoryCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: CategorySlider.self)

    var category: Category?

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

    func set(category: Category) {
        label.text = category.name
        self.color = category.color
        self.category = category

        if category.isSelected {
            changeColor()
        }
    }

    func changeColor() {
        label.textColor = color
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
        label.font = UIFont(name: "SourceSansPro-Bold", size: 20)
    }

    func defineLayoutForViews() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
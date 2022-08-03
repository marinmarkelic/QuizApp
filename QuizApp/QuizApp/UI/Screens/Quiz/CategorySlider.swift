import UIKit

class CategorySlider: UIView {

    private var categories: [Category] = []

    private var collectionView: UICollectionView!
    private var collectionViewLayout: UICollectionViewFlowLayout!

    weak var delegate: CategorySliderDelegate!

    override init(frame: CGRect) {
        super.init(frame: frame)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reload(with categories: [Category]) {
        self.categories = categories

        collectionView.reloadData()
    }

    func redraw() {
        collectionViewLayout.invalidateLayout()
    }

}

extension CategorySlider: ConstructViewsProtocol {

    func createViews() {
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        addSubview(collectionView)
    }

    func styleViews() {
        collectionViewLayout.scrollDirection = .horizontal

        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
    }

    func defineLayoutForViews() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

extension CategorySlider: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let widthOffset: CGFloat = 5

        let text = categories[indexPath.row].name
        let font: UIFont = .heading4

        let size = text.size(withAttributes: [
            .font: font
        ])

        let itemWidth = CGFloat(size.width + widthOffset)
        let itemHeight = CGFloat(size.height)

        return CGSize(width: itemWidth, height: itemHeight)
    }

}

extension CategorySlider: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCell.reuseIdentifier,
            for: indexPath) as? CategoryCell
        else {
            return CategoryCell()
        }

        cell.set(category: categories[indexPath.row])

        return cell
    }

}

extension CategorySlider: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.selectedCategory(self, category: categories[indexPath.row])
    }

}

protocol CategorySliderDelegate: AnyObject {

    func selectedCategory(_ categorySlider: CategorySlider, category: Category)

}

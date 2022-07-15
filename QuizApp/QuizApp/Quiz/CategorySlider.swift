import UIKit

class CategorySlider: UIView {

    private var collectionView: UICollectionView!
    private var collectionViewLayout: UICollectionViewFlowLayout!

    override init(frame: CGRect) {
        super.init(frame: frame)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        collectionView.backgroundColor = .none
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

        let text = categories[indexPath.row].name
        let font = UIFont(name: "SourceSansPro-Bold", size: 20) ?? UIFont.systemFont(ofSize: 20)

        print(font)

        let size = text.size(withAttributes: [
            .font: font
        ])

        let itemWidth = CGFloat(size.width + 5)
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
        else { fatalError() }

        let categoryData = categories[indexPath.row]

        cell.set(title: categoryData.name, color: categoryData.color)

        return cell
    }

}

extension CategorySlider: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for view in collectionView.subviews {
            guard let cell = view as? CategoryCell else { continue }

            cell.resetColor()
        }

        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell else { return }

        cell.changeColor()
    }

}

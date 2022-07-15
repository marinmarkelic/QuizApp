import UIKit

class QuizView: UIView {

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

extension QuizView: ConstructViewsProtocol {

    func createViews() {
        collectionViewLayout = UICollectionViewFlowLayout()

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        addSubview(collectionView)
    }

    func styleViews() {
        collectionViewLayout.scrollDirection = .vertical

        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.register(QuizCell.self, forCellWithReuseIdentifier: QuizCell.reuseIdentifier)
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

extension QuizView: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let itemWidth = CGFloat(frame.width)
        let itemHeight = CGFloat(140)

        return CGSize(width: itemWidth, height: itemHeight)
    }

}

extension QuizView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mockInfo.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: QuizCell.reuseIdentifier,
            for: indexPath) as? QuizCell
        else { fatalError() }

        //change
        cell.set(color: .yellow)
        cell.set(info: mockInfo[indexPath.row])

        return cell
    }

}

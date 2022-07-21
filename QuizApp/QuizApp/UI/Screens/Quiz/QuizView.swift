import UIKit

class QuizView: UIView {

    private var quizzes: [Quiz] = []
    private var category: CategoryType?

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

    func redraw() {
        collectionViewLayout.invalidateLayout()
    }

    func reload(with quizzes: [Quiz]) {
        self.quizzes = quizzes
        collectionView.reloadData()
    }

    func reload(with category: CategoryType) {
        self.category = category
        collectionView.reloadData()
    }

}

extension QuizView: ConstructViewsProtocol {

    func createViews() {
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        addSubview(collectionView)
    }

    func styleViews() {
        collectionViewLayout.headerReferenceSize = CGSize(width: 100, height: 20)
        collectionViewLayout.sectionHeadersPinToVisibleBounds = true

        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.register(QuizCell.self, forCellWithReuseIdentifier: QuizCell.reuseIdentifier)
        collectionView.register(
            QuizHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: QuizHeader.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
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

extension QuizView: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let itemHeight: CGFloat = 140

        return CGSize(width: frame.width, height: itemHeight)
    }

}

extension QuizView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let isAllSelected = category == .all
        return isAllSelected ? CategoryType.allCases.count - 1 : 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = CategoryType
            .allCases[section + 1]
        return quizzes
            .filter { $0.category.type == category }
            .count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let quizHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: QuizHeader.reuseIdentifier,
            for: indexPath
        ) as? QuizHeader else {
            return QuizHeader()
        }

        quizHeader.set(title: "Sport", color: .sportColor)
        return quizHeader
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: QuizCell.reuseIdentifier,
            for: indexPath) as? QuizCell
        else { return QuizCell() }

        cell.set(quiz: quizzes[indexPath.row])

        return cell
    }

}
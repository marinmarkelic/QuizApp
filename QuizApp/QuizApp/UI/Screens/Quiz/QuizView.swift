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
        makeCollectionViewLayout()

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        addSubview(collectionView)
    }

    func styleViews() {
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

    private func makeCollectionViewLayout() {
        collectionViewLayout.headerReferenceSize = CGSize(width: 100, height: 20)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
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
        Set(quizzes.map { $0.category }).count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if category != .all {
            return quizzes.count
        }

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

        let categories = Array(Set(quizzes.map { $0.category })).sorted(by: {$0.hashValue > $1.hashValue})

        let dontShowHeader = category != .all || categories.count <= indexPath.section
        quizHeader.isHidden = dontShowHeader

        let sectionCategory = categories[indexPath.section]
        quizHeader.set(title: sectionCategory.name, color: sectionCategory.color)

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

        let category = Array(Set(quizzes.map { $0.category }))
            .sorted(by: { $0.hashValue > $1.hashValue })[indexPath.section]
        let quizzes = quizzes
            .filter { $0.category == category }

        cell.set(quiz: quizzes[indexPath.row])

        return cell
    }

}

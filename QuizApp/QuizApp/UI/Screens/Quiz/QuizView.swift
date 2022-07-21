import UIKit

class QuizView: UIView {

    private var quizzes: [Quiz] = []

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
        Set(quizzes
            .map { $0.category })
        .count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let categories = Array(Set(quizzes.map { $0.category })).sorted(by: {$0.name > $1.name})

        if categories.count == 1 {
            return quizzes.count
        }

        let sectionCategory = CategoryType.allCases[section + 1]

        return quizzes
            .filter { $0.category.type == sectionCategory }
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

        let categories = Array(Set(quizzes.map { $0.category })).sorted(by: {$0.name > $1.name})

        quizHeader.isHidden = categories.count == 1

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

        let sectionCategory = Array(Set(quizzes.map { $0.category }))
            .sorted { $0.name > $1.name }[indexPath.section]
        let sectionQuizzes = quizzes
            .filter { $0.category == sectionCategory }
            .sorted { $0.difficulty < $1.difficulty }

        cell.set(quiz: sectionQuizzes[indexPath.row])

        return cell
    }

}

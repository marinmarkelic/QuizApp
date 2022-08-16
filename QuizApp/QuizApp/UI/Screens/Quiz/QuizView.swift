import Combine
import UIKit

class QuizView: UIView {

    private let quizSubject = PassthroughSubject<Quiz, Never>()
    private var quizzes: [Quiz] = []

    private var alwaysShowHeaders: Bool

    private var collectionView: UICollectionView!
    private var collectionViewLayout: UICollectionViewFlowLayout!

    var selectedQuiz: AnyPublisher<Quiz, Never> {
        quizSubject.eraseToAnyPublisher()
    }

    // This is needed because QuizView doesn't need headers
    // in QuizVC when there are only quizzes from one category.
    // However headers always need to be shown in SearchVC.
    init(alwaysShowHeaders: Bool = false) {
        self.alwaysShowHeaders = alwaysShowHeaders

        super.init(frame: .zero)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    override init(frame: CGRect) {
        alwaysShowHeaders = false

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
        self.quizzes = quizzes.sorted {
            if $0.category.index == $1.category.index {
                return $0.difficulty < $1.difficulty
            }

            return $0.category.index < $1.category.index
        }

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
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 30, right: 0)
    }

}

extension QuizView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let quiz: Quiz = quizzes[determineQuizIndex(collectionView, indexPath: indexPath)]
        quizSubject.send(quiz)
    }

    private func determineQuizIndex(_ collectionView: UICollectionView, indexPath: IndexPath) -> Int {
        var result = 0

        for index in 0..<collectionView.numberOfSections {
            if index < indexPath.section {
                result += collectionView.numberOfItems(inSection: index)
            } else {
                result += indexPath.row
                break
            }
        }

        return result
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

        quizHeader.isHidden = !alwaysShowHeaders && categories.count == 1

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

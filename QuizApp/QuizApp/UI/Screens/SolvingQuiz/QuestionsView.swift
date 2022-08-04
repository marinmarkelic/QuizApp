import Combine
import UIKit

class QuestionsView: UIView {

    private let idSubject = PassthroughSubject<Int, Never>()

    private var questions: [Question] = []

    private var collectionViewLayout: UICollectionViewFlowLayout!
    private var collectionView: UICollectionView!

    private var cancellables = Set<AnyCancellable>()

    var selectedId: AnyPublisher<Int, Never> {
        idSubject.eraseToAnyPublisher()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(questions: [Question]) {
        self.questions = questions
        collectionView.reloadData()
    }

    func scrollToQuestion(at index: Int, animated: Bool = true) {
        if index > collectionView.numberOfSections - 1 { return }

        collectionView.scrollToItem(
            at: IndexPath(row: 0, section: index),
            at: .centeredHorizontally,
            animated: animated)
    }

    func redraw(with index: Int) {
        collectionViewLayout.invalidateLayout()
        collectionView.performBatchUpdates(nil) {_ in
            self.scrollToQuestion(at: index, animated: false)
        }
    }

}

extension QuestionsView: ConstructViewsProtocol {

    func createViews() {
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        addSubview(collectionView)
    }

    func styleViews() {
        collectionViewLayout.scrollDirection = .horizontal

        collectionView.isScrollEnabled = false
        collectionView.register(QuestionCell.self, forCellWithReuseIdentifier: QuestionCell.reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
    }

    func defineLayoutForViews() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

extension QuestionsView: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if UIDevice.current.orientation.isPortrait {
            let heightOffset: CGFloat = 30
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height - heightOffset)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        } else if section == collectionView.numberOfSections - 1 {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }

}

extension QuestionsView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        questions.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: QuestionCell.reuseIdentifier,
            for: indexPath) as? QuestionCell
        else { return QuestionCell() }

        cell.set(
            title: questions[indexPath.section].question,
            answers: questions[indexPath.section].answers)

        cell
            .selectedId
            .sink { [weak self] id in
                self?.idSubject.send(id)
            }
            .store(in: &cancellables)

        return cell
    }

}

extension QuestionsView: UICollectionViewDelegate {}

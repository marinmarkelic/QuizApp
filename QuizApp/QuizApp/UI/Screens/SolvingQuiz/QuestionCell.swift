import Combine
import UIKit

class QuestionCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: QuestionCell.self)

    private let idSubject = PassthroughSubject<Int, Never>()

    private var scrollView: UIScrollView!
    private var mainView: UIView!

    private var label: UILabel!
    private var stackView: UIStackView!

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

    func set(title: String, answers: [Answer]) {
        label.text = title

        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        answers.forEach {
            let answerView = AnswerView()
            answerView.set(answer: $0)

            stackView.addArrangedSubview(answerView)

            answerView
                .selectedId
                .sink { [weak self] id in
                    self?.idSubject.send(id)
                }
                .store(in: &cancellables)
        }
    }

}

extension QuestionCell: ConstructViewsProtocol {

    func createViews() {
        scrollView = UIScrollView()
        addSubview(scrollView)

        mainView = UIView()
        scrollView.addSubview(mainView)

        label = UILabel()
        mainView.addSubview(label)

        stackView = UIStackView()
        mainView.addSubview(stackView)
    }

    func styleViews() {
        scrollView.showsVerticalScrollIndicator = false

        label.font = .heading3
        label.textColor = .white
        label.numberOfLines = 0

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
    }

    func defineLayoutForViews() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        label.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }

}

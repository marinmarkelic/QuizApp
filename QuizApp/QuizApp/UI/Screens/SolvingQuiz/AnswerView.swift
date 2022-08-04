import Combine
import UIKit

class AnswerView: UIView {

    private let idSubject = PassthroughSubject<Int, Never>()

    private var id: Int!
    private var label: UILabel!

    private var cancellables = Set<AnyCancellable>()

    var selectedId: AnyPublisher<Int, Never> {
        idSubject.eraseToAnyPublisher()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        createViews()
        styleViews()
        defineLayoutForViews()
        bindViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(answer: Answer) {
        id = answer.id
        label.text = answer.answer
        backgroundColor = answer.color
    }

    private func bindViews() {
        self
            .tap
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.idSubject.send(self.id)
            }
            .store(in: &cancellables)
    }

}

extension AnswerView: ConstructViewsProtocol {

    func createViews() {
        label = UILabel()
        addSubview(label)
    }

    func styleViews() {
        layer.cornerRadius = 30

        label.font = .heading4
        label.textColor = .white
        label.numberOfLines = 0
    }

    func defineLayoutForViews() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }

}

import UIKit

class AnswerView: UIView {

    weak var delegate: AnswerViewDelegate?

    private var id: Int!
    private var label: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(answer: Answer) {
        id = answer.id
        label.text = answer.answer
        backgroundColor = answer.color
    }

}

extension AnswerView: ConstructViewsProtocol {

    func createViews() {
        label = UILabel()
        addSubview(label)
    }

    func styleViews() {
        layer.cornerRadius = 30

        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectedAnswer))
        addGestureRecognizer(gesture)

        label.font = .heading4
        label.textColor = .white
        label.numberOfLines = 0
    }

    @objc
    private func selectedAnswer() {
        delegate?.selectedAnswer(with: id)
    }

    func defineLayoutForViews() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }

}

protocol AnswerViewDelegate: AnyObject {

    func selectedAnswer(with id: Int)

}

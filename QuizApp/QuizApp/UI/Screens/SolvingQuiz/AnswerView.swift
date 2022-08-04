import Combine
import UIKit

class AnswerView: UIView {

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

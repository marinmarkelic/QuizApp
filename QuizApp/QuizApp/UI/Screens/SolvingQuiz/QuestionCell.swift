import UIKit

class QuestionCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: QuestionCell.self)

    private var label: UILabel!
    private var stackView: UIStackView!

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

        for answer in answers {
            let answerView = AnswerView()
            answerView.set(id: answer.id, text: answer.answer)

            stackView.addArrangedSubview(answerView)
        }
    }

}

extension QuestionCell: ConstructViewsProtocol {

    func createViews() {
        label = UILabel()
        addSubview(label)

        stackView = UIStackView()
        addSubview(stackView)
    }

    func styleViews() {
        label.font = UIFont(name: "SourceSansPro-Bold", size: 24)
        label.textColor = .white
        label.numberOfLines = 0

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
    }

    func defineLayoutForViews() {
        label.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
        }
    }

}

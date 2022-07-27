import UIKit

class AnswerView: UIView {

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

    func set(id: Int, text: String) {
        self.id = id
        label.text = text
    }

}

extension AnswerView: ConstructViewsProtocol {

    func createViews() {
        label = UILabel()
        addSubview(label)
    }

    func styleViews() {
        layer.cornerRadius = 30
        backgroundColor = .white.withAlphaComponent(0.3)

        label.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        label.textColor = .white
    }

    func defineLayoutForViews() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }

}

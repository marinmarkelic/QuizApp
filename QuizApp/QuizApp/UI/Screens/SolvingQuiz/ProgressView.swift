import UIKit

class ProgressView: UIView {

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

    func set(numberOfQuestions: Int) {
        if numberOfQuestions < 1 || label == nil { return }

        label.text = "1/\(numberOfQuestions)"

        setupStackView(numberOfQuestions: numberOfQuestions)
    }

    private func setupStackView(numberOfQuestions: Int) {
        for _ in 0..<numberOfQuestions {
            let cell = UIView()
            cell.backgroundColor = .white.withAlphaComponent(0.3)
            cell.layer.cornerRadius = 2

            stackView.addArrangedSubview(cell)
        }
    }

}

extension ProgressView: ConstructViewsProtocol {
    func createViews() {
        label = UILabel()
        addSubview(label)

        stackView = UIStackView()
        addSubview(stackView)
    }

    func styleViews() {
        label.textColor = .white
        label.font = UIFont(name: "SourceSansPro-Bold", size: 18)

        stackView.axis = .horizontal //
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
    }

    func defineLayoutForViews() {
        label.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(5)
        }
    }

}

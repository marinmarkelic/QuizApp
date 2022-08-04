import UIKit

class SearchBar: UIView {

    private var textField: TextFieldView!
    private var button: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SearchBar: ConstructViewsProtocol {

    func createViews() {
        textField = TextFieldView()
        addSubview(textField)

        button = UIButton()
        addSubview(button)
    }

    func styleViews() {
        textField.setPlaceholder(with: "Type here")

        button.setTitle("Search", for: .normal) // Style
    }

    func defineLayoutForViews() {
        textField.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }

        button.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(textField.snp.trailing).offset(10)
        }
    }

}

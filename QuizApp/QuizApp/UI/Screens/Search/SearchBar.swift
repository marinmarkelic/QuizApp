import Combine
import UIKit

class SearchBar: UIView {

    private let textSubject = PassthroughSubject<String, Never>()
    private let searchSubject = PassthroughSubject<Void, Never>()

    private var textField: TextFieldView!
    private var button: UIButton!

    private var cancellables = Set<AnyCancellable>()

    var searchText: AnyPublisher<String, Never> {
        textSubject.eraseToAnyPublisher()
    }

    var onSearchPress: AnyPublisher<Void, Never> {
        searchSubject.eraseToAnyPublisher()
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

    private func bindViews() {
        textField
            .text
            .sink { [weak self] text in
                self?.textSubject.send(text)
            }
            .store(in: &cancellables)

        button
            .tap
            .sink { [weak self] _ in
                self?.searchSubject.send()
            }
            .store(in: &cancellables)
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

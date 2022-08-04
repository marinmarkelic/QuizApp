import Combine
import UIKit

class SearchViewController: UIViewController {

    private let viewModel: SearchViewModel

    private var gradientView: GradientView!
    private var mainView: UIView!

    private var searchBar: SearchBar!
    private var quizView: QuizView!

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        styleTabBarItem()

        createViews()
        styleViews()
        defineLayoutForViews()
        bindViews()
        bindViewModel()
    }

    private func bindViews() {
//        view
//            .tap
//            .sink { [weak self] _ in
//                self?.searchBar.endEditing()
//            }
//            .store(in: &cancellables)

        searchBar
            .searchText
            .sink { [weak self] text in
                self?.viewModel.updatedSearchText(with: text)
            }
            .store(in: &cancellables)

        searchBar
            .onSearchPress
            .sink { [weak self] _ in
                self?.viewModel.fetchQuizzes()
            }
            .store(in: &cancellables)

        quizView
            .selectedQuiz
            .sink { [weak self] quiz in
                self?.viewModel.showQuizDetails(with: quiz)
            }
            .store(in: &cancellables)
    }

    private func bindViewModel() {
        viewModel
            .$quizzes
            .sink { [weak self] quizzes in
                self?.quizView.reload(with: quizzes)
            }
            .store(in: &cancellables)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func styleTabBarItem() {
        let config = UIImage.SymbolConfiguration(scale: .medium)

        tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass", withConfiguration: config),
            selectedImage: UIImage(systemName: "magnifyingglass", withConfiguration: config))
    }

}

extension SearchViewController: ConstructViewsProtocol {

    func createViews() {
        gradientView = GradientView()
        view.addSubview(gradientView)

        mainView = UIView()
        gradientView.addSubview(mainView)

        searchBar = SearchBar()
        mainView.addSubview(searchBar)

        quizView = QuizView()
        mainView.addSubview(quizView)
    }

    func styleViews() {

    }

    func defineLayoutForViews() {
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        searchBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(20)
        }

        quizView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }

}
import UIKit

class SearchViewController: UIViewController {

    private let viewModel: SearchViewModel

    private var gradientView: GradientView!
    private var mainView: UIView!

    private var searchBar: SearchBar!
    private var quizView: QuizView!

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        createViews()
        styleViews()
        defineLayoutForViews()
        styleTabBarItem()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func styleTabBarItem() {
        let config = UIImage.SymbolConfiguration(scale: .medium)

        tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "rectangle.3.offgrid", withConfiguration: config),
            selectedImage: UIImage(systemName: "rectangle.3.offgrid.fill", withConfiguration: config))
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

//        quizView = QuizView()
//        mainView.addSubview(quizView)
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
    }

}

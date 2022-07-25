import UIKit

class QuizDetailsViewController: UIViewController {

    private var detailsView: DetailsView!

    init() {
        super.init(nibName: nil, bundle: nil)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(quiz: Quiz) {
        detailsView.set(quiz: quiz)
    }

}

extension QuizDetailsViewController: ConstructViewsProtocol {

    func createViews() {
        detailsView = DetailsView()
        view.addSubview(detailsView)
    }

    func styleViews() {
        view.backgroundColor = .clear
    }

    func defineLayoutForViews() {
        detailsView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}

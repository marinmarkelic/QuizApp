import UIKit

class QuizResultViewController: UIViewController {

    private var viewModel: QuizResultViewModel!

    private var label: UILabel!

    init(viewModel: QuizResultViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension QuizResultViewController: ConstructViewsProtocol {

    func createViews() {
        label = UILabel()
        view.addSubview(label)
    }

    func styleViews() {
        label.font = UIFont(name: "SourceSansPro-Bold", size: 88)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "teest"
    }

    func defineLayoutForViews() {
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(50)
        }
    }

}

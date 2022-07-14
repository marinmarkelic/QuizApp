import UIKit

class QuizViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        styleViews()
    }

}

extension QuizViewController: ConstructViewsProtocol {
    func createViews() {}

    func styleViews() {
        let config = UIImage.SymbolConfiguration(scale: .medium)

        tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "rectangle.3.offgrid", withConfiguration: config),
            selectedImage: UIImage(systemName: "rectangle.3.offgrid.fill", withConfiguration: config))
    }

    func defineLayoutForViews() {}

}

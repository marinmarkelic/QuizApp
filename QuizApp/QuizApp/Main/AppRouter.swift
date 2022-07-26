import UIKit
import Resolver

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController
    private let container: Resolver

    init(container: Resolver) {
        self.container = container
        navigationController = UINavigationController()
    }

    func start(in window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        showInitialViewController()
    }

    func showLogin() {
        let loginViewController = container.resolve(LoginViewController.self)
        navigationController.setViewControllers([loginViewController], animated: true)
    }

    func showHome() {
        let quizViewController = container.resolve(QuizViewController.self)
        let userViewController = container.resolve(UserViewController.self)

        let viewControllers = [quizViewController, userViewController]

        let tabBarController = TabBarController(viewControllers: viewControllers)

        navigationController.setViewControllers([tabBarController], animated: true)
    }

    func showQuizDetails(with quiz: Quiz) {
        let quizDetailsViewController = container.resolve(QuizDetailsViewController.self)
        quizDetailsViewController.set(quiz: quiz)

        navigationController.pushViewController(quizDetailsViewController, animated: true)
    }

    func showQuiz() {
        let solvingQuizViewController = SolvingQuizViewController(solvingQuizViewModel: container.resolve(), appRouter: container.resolve())
        navigationController.pushViewController(solvingQuizViewController, animated: true)
    }

    private func showInitialViewController() {
        Task {
            do {
                let userNetworkDataSource = container.resolve(UserNetworkDataSourceProtocol.self)
                try await userNetworkDataSource.check()

                DispatchQueue.main.async { [weak self] in
                    self?.showHome()
                }
            } catch {
                container.resolve(SecureStorageProtocol.self).deleteAccessToken()

                DispatchQueue.main.async { [weak self] in
                    self?.showLogin()
                }
            }
        }
    }

}

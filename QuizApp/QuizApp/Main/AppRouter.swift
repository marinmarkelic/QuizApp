import UIKit
import Resolver
import SwiftUI

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController
    private let container: Resolver

    private var tabBarController: TabBarController? {
        return navigationController.viewControllers.first as? TabBarController
    }

    init(container: Resolver) {
        self.container = container
        navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
    }

    func start(in window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        showInitialViewController()
    }

    func showLogin() {
        let loginViewController = container.resolve(UIHostingController<LoginView>.self)
        navigationController.setViewControllers([loginViewController], animated: true)
    }

    func showHome() {
        if tabBarController != nil {
            navigationController.popToRootViewController(animated: true)
            return
        }

        let quizViewController = container.resolve(QuizViewController.self)
        let searchViewController = container.resolve(SearchViewController.self)
        let userViewController = container.resolve(UIHostingController<SettingsView>.self)

        let viewControllers = [quizViewController, searchViewController, userViewController]

        let tabBarController = TabBarController(viewControllers: viewControllers)

        navigationController.setViewControllers([tabBarController], animated: true)
    }

    func showQuizDetails(with quiz: Quiz) {
        let quizDetailsViewController = container.resolve(QuizDetailsViewController.self, args: quiz)
        navigationController.pushViewController(quizDetailsViewController, animated: true)
    }

    func showLeaderboard(with id: Int) {
        let leaderboardViewController = container.resolve(LeaderboardViewController.self, args: id)
        navigationController.pushViewController(leaderboardViewController, animated: true)
    }

    func showQuiz(with id: Int) {
        let solvingQuizViewController = container.resolve(SolvingQuizViewController.self, args: id)
        navigationController.pushViewController(solvingQuizViewController, animated: true)
    }

    func showResults(with result: QuizResult) {
        let quizResultViewController = container.resolve(QuizResultViewController.self, args: result)
        navigationController.pushViewController(quizResultViewController, animated: true)
    }

    func goBack() {
        navigationController.popViewController(animated: true)
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

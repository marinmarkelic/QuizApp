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

        styleSettingsTabBar(userViewController)

        let viewControllers = [quizViewController, searchViewController, userViewController]

        let tabBarController = TabBarController(viewControllers: viewControllers)

        navigationController.setViewControllers([tabBarController], animated: true)
    }

    private func styleSettingsTabBar(_ viewController: UIViewController) {
        let config = UIImage.SymbolConfiguration(scale: .medium)

        viewController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape", withConfiguration: config),
            selectedImage: UIImage(systemName: "gearshape.fill", withConfiguration: config))
    }

    func showQuizDetails(with quiz: Quiz) {
        let quizDetailsViewController = container.resolve(UIHostingController<QuizDetailsView>.self, args: quiz)
        styleQuizDetailsNavigationBar(quizDetailsViewController)
        navigationController.pushViewController(quizDetailsViewController, animated: true)
    }

    private func styleQuizDetailsNavigationBar(_ viewController: UIViewController) {
        let titleView = UILabel()
        titleView.text = "PopQuiz"
        titleView.textColor = .white
        titleView.font = .heading3
        viewController.navigationItem.titleView = titleView

        viewController.navigationItem.hidesBackButton = true

        let config = UIImage.SymbolConfiguration(scale: .medium)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        let closeButton = UIBarButtonItem(
            image: image,
            style: .done,
            target: self,
            action: #selector(tappedClose))
        closeButton.tintColor = .white
        viewController.navigationItem.leftBarButtonItem = closeButton
    }

    func showLeaderboard(with id: Int) {
        let leaderboardViewController = container.resolve(UIHostingController<LeaderboardView>.self, args: id)
        styleLeaderboardNavigationBar(leaderboardViewController)
        navigationController.pushViewController(leaderboardViewController, animated: true)
    }

    private func styleLeaderboardNavigationBar(_ viewController: UIViewController) {
        let titleView = UILabel()
        titleView.text = "Leaderboard"
        titleView.textColor = .white
        titleView.font = .heading3
        viewController.navigationItem.titleView = titleView

        viewController.navigationItem.hidesBackButton = true

        let config = UIImage.SymbolConfiguration(scale: .medium)
        let image = UIImage(systemName: "xmark", withConfiguration: config)
        let closeButton = UIBarButtonItem(
            image: image,
            style: .done,
            target: self,
            action: #selector(tappedClose))
        closeButton.tintColor = .white
        viewController.navigationItem.rightBarButtonItem = closeButton
    }

    @objc
    private func tappedClose() {
        navigationController.popViewController(animated: true)
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

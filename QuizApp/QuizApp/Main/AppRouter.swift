import UIKit
import Resolver
import SwiftUI

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController
    private let container: Resolver

    private var tabBarController: UIHostingController<TabBarView>? {
        return navigationController.viewControllers.first as? UIHostingController<TabBarView>
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

        let tabBarController = UIHostingController(
            rootView: TabBarView(
                quizViewModel: container.resolve(),
                searchViewModel: container.resolve(),
                userViewModel: container.resolve()))

        navigationController.setViewControllers([tabBarController], animated: true)
    }

    private func styleQuizTabBar(_ viewController: UIViewController) {
        let config = UIImage.SymbolConfiguration(scale: .medium)

        viewController.tabBarItem = UITabBarItem(
            title: "Quiz",
            image: UIImage(systemName: "rectangle.3.offgrid", withConfiguration: config),
            selectedImage: UIImage(systemName: "rectangle.3.offgrid.fill", withConfiguration: config))
    }

    private func styleSettingsTabBar(_ viewController: UIViewController) {
        let config = UIImage.SymbolConfiguration(scale: .medium)

        viewController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape", withConfiguration: config),
            selectedImage: UIImage(systemName: "gearshape.fill", withConfiguration: config))
    }

    private func styleSearchTabBar(_ viewController: UIViewController) {
        let config = UIImage.SymbolConfiguration(scale: .medium)

        viewController.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass", withConfiguration: config),
            selectedImage: UIImage(systemName: "magnifyingglass", withConfiguration: config))
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
        let backButton = UIBarButtonItem(
            image: image,
            style: .done,
            target: self,
            action: #selector(tappedClose))
        backButton.tintColor = .white
        viewController.navigationItem.leftBarButtonItem = backButton
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
        let solvingQuizViewController = container.resolve(UIHostingController<SolvingQuizView>.self, args: id)
        styleSolvingQuizNavigationBar(solvingQuizViewController)
        navigationController.pushViewController(solvingQuizViewController, animated: true)
    }

    private func styleSolvingQuizNavigationBar(_ viewController: UIViewController) {
        let titleView = UILabel()
        titleView.text = "PopQuiz"
        titleView.textColor = .white
        titleView.font = .heading3
        viewController.navigationItem.titleView = titleView

        viewController.navigationItem.hidesBackButton = true

        let config = UIImage.SymbolConfiguration(scale: .medium)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        let backButton = UIBarButtonItem(
            image: image,
            style: .done,
            target: self,
            action: #selector(tappedClose))
        backButton.tintColor = .white
        viewController.navigationItem.leftBarButtonItem = backButton
    }

    func showResults(with result: QuizResult) {
        let quizResultViewController = container.resolve(UIHostingController<QuizResultView>.self, args: result)
        styleQuizResultNavigationBar(quizResultViewController)
        navigationController.pushViewController(quizResultViewController, animated: true)
    }

    private func styleQuizResultNavigationBar(_ viewController: UIViewController) {
        viewController.navigationItem.hidesBackButton = true
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

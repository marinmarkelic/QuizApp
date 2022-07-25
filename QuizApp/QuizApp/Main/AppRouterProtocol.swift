import UIKit

protocol AppRouterProtocol {

    func start(in window: UIWindow)

    func showLogin()

    func showHome()

    func showQuizDetails(with quiz: Quiz)

}

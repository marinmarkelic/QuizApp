import UIKit

protocol AppRouterProtocol {

    func start(in window: UIWindow)

    func showLogin()

    func showHome()

    func showQuizDetails(with quiz: Quiz)

    func showQuiz(with id: Int)

    func showResults(with result: QuizResult)

    func goBack()

}

import Resolver
import UIKit

class AppDependencies {

    private let baseUrl = "https://five-ios-quiz-app.herokuapp.com/api"

    private lazy var container: Resolver = {
        let container = Resolver()
        registerDependencies(in: container)
        return container
    }()

    lazy var appRouter: AppRouterProtocol = {
        container.resolve()
    }()

    func registerDependencies(in container: Resolver) {
        container
            .register { AppRouter(container: container) }
            .implements(AppRouterProtocol.self)
            .scope(.application)

        container
            .register { SecureStorage() }
            .implements(SecureStorageProtocol.self)
            .scope(.application)

        registerNetworkClients(in: container)
        registerDataSources(in: container)
        registerRepos(in: container)
        registerUseCases(in: container)
        registerViewModels(in: container)
        registerViewControllers(in: container)
    }

    private func registerNetworkClients(in container: Resolver) {
        container
            .register { NetworkClient(secureStorage: container.resolve(), baseUrl: self.baseUrl) }
            .scope(.application)

        container
            .register { LoginNetworkClient(networkClient: container.resolve()) }
            .implements(LoginNetworkClientProtocol.self)
            .scope(.application)

        container
            .register { CheckNetworkClient(networkClient: container.resolve()) }
            .implements(CheckNetworkClientProtocol.self)
            .scope(.application)

        container
            .register { UserNetworkClient(networkClient: container.resolve()) }
            .implements(UserNetworkClientProtocol.self)
            .scope(.application)

        container
            .register { QuizNetworkClient(networkClient: container.resolve()) }
            .implements(QuizNetworkClientProtocol.self)
            .scope(.application)
    }

    private func registerDataSources(in container: Resolver) {
        container
            .register {
                UserNetworkDataSource(
                    loginNetworkClient: container.resolve(),
                    checkNetworkClient: container.resolve(),
                    userNetworkClient: container.resolve())
            }
            .implements(UserNetworkDataSourceProtocol.self)
            .scope(.application)

        container
            .register { QuizNetworkDataSource(quizNetworkClient: container.resolve()) }
            .implements(QuizNetworkDataSourceProtocol.self)
            .scope(.application)

        container
            .register { UserDatabaseDataSource(secureStorage: container.resolve()) }
            .implements(UserDatabaseDataSourceProtocol.self)
            .scope(.application)
    }

    private func registerRepos(in container: Resolver) {
        container
            .register {
                UserRepository(
                    userNetworkDataSource: container.resolve(),
                    userDatabaseDataSource: container.resolve())
            }
            .implements(UserRepositoryProtocol.self)
            .scope(.application)

        container
            .register { QuizRepository(quizNetworkDataSource: container.resolve()) }
            .implements(QuizRepositoryProtocol.self)
            .scope(.application)
    }

    private func registerUseCases(in container: Resolver) {
        container
            .register { LoginUseCase(userRepository: container.resolve()) }
            .implements(LoginUseCaseProtocol.self)
            .scope(.application)

        container
            .register { UserUseCase(userRepository: container.resolve()) }
            .implements(UserUseCaseProtocol.self)
            .scope(.application)

        container
            .register { LogOutUseCase(userRepository: container.resolve()) }
            .implements(LogOutUseCaseProtocol.self)
            .scope(.application)

        container
            .register { QuizUseCase(quizRepository: container.resolve()) }
            .implements(QuizUseCaseProtocol.self)
            .scope(.application)

        container
            .register { SolvingQuizUseCase(quizRepository: container.resolve()) }
            .implements(SolvingQuizUseCaseProtocol.self)
            .scope(.unique)
    }

    private func registerViewModels(in container: Resolver) {
        container
            .register { LoginViewModel(loginUseCase: container.resolve(), appRouter: container.resolve()) }
            .scope(.unique)

        container
            .register { QuizViewModel(quizUseCase: container.resolve(), container: container) }
            .scope(.unique)

        container
            .register {
                UserViewModel(
                    appRouter: container.resolve(),
                    userUseCase: container.resolve(),
                    logoutUseCase: container.resolve())
            }
            .scope(.unique)
    }

    private func registerViewControllers(in container: Resolver) {
        container
            .register { LoginViewController(loginViewModel: container.resolve()) }
            .scope(.unique)

        container
            .register {
                QuizViewController(
                    quizViewModel: container.resolve(),
                    appRouter: container.resolve())
            }
            .scope(.unique)

        container
            .register { QuizDetailsViewController() }
            .scope(.unique)

        container
            .register { UserViewController(userViewModel: container.resolve()) }
            .scope(.unique)
    }

}

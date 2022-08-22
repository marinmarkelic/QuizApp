import Resolver
import UIKit
import SwiftUI

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
            .register { QuizNetworkDataSource(networkClient: container.resolve()) }
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
            .register { LoginUseCase(repository: container.resolve()) }
            .implements(LoginUseCaseProtocol.self)
            .scope(.application)

        container
            .register { UserUseCase(repository: container.resolve()) }
            .implements(UserUseCaseProtocol.self)
            .scope(.application)

        container
            .register { LogOutUseCase(repository: container.resolve()) }
            .implements(LogOutUseCaseProtocol.self)
            .scope(.application)

        container
            .register { QuizUseCase(repository: container.resolve()) }
            .implements(QuizUseCaseProtocol.self)
            .scope(.application)

        container
            .register { LeaderboardUseCase(repository: container.resolve()) }
            .implements(LeaderboardUseCaseProtocol.self)
            .scope(.application)

        container
            .register { SolvingQuizUseCase(repository: container.resolve()) }
            .implements(SolvingQuizUseCaseProtocol.self)
            .scope(.application)
    }

    private func registerViewModels(in container: Resolver) {
        container
            .register { LoginViewModel(router: container.resolve(), useCase: container.resolve()) }
            .scope(.unique)

        container
            .register { QuizViewModel(router: container.resolve(), useCase: container.resolve()) }
            .scope(.unique)

        container
            .register {
                UserViewModel(
                    router: container.resolve(),
                    userUseCase: container.resolve(),
                    logoutUseCase: container.resolve())
            }
            .scope(.unique)

        container
            .register { (_, args) -> QuizDetailsViewModel in
                QuizDetailsViewModel(quiz: args.get(), router: container.resolve())
            }
            .scope(.unique)

        container
            .register { (_, args) -> LeaderboardViewModel in
                LeaderboardViewModel(id: args.get(), useCase: container.resolve(), router: container.resolve())
            }
            .scope(.unique)

        container
            .register { (_, args) -> SolvingQuizViewModel in
                SolvingQuizViewModel(
                    id: args.get(),
                    router: container.resolve(),
                    useCase: container.resolve())
            }
            .scope(.unique)

        container
            .register { (_, args) -> QuizResultViewModel in
                QuizResultViewModel(
                    result: args.get(),
                    router: container.resolve(),
                    useCase: container.resolve())
            }
            .scope(.unique)

        container
            .register { SearchViewModel(router: container.resolve(), useCase: container.resolve()) }
            .scope(.unique)
    }

    private func registerViewControllers(in container: Resolver) {
        container
            .register { UIHostingController(rootView: LoginView(viewModel: container.resolve())) }
            .scope(.unique)

        container
            .register { UIHostingController(rootView: QuizView()) }
            .scope(.unique)

        container
            .register { (_, args) -> UIHostingController<QuizDetailsView> in
                UIHostingController(rootView: QuizDetailsView(viewModel: container.resolve(args: args.get())))
            }
            .scope(.unique)

        container
            .register { (_, args) -> UIHostingController<LeaderboardView> in
                UIHostingController(rootView: LeaderboardView(viewModel: container.resolve(args: args.get())))
            }
            .scope(.unique)

        container
            .register { UIHostingController(rootView: SettingsView(viewModel: container.resolve())) }
            .scope(.unique)

        container
            .register { (_, args) -> SolvingQuizViewController in
                SolvingQuizViewController(viewModel: container.resolve(args: args.get()))
            }
            .scope(.unique)

        container
            .register { (_, args) -> QuizResultViewController in
                QuizResultViewController(viewModel: container.resolve(args: args.get()))
            }
            .scope(.unique)

        container
            .register { UIHostingController(rootView: SearchView(viewModel: container.resolve())) }
            .scope(.unique)
    }

}

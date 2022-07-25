import Resolver

class AppDependencies {

    private let baseUrl = "https://five-ios-quiz-app.herokuapp.com/api"

    lazy var container: Resolver = {
        let container = Resolver()
        registerDependencies(in: container)
        return container
    }()

    func registerDependencies(in container: Resolver) {
        container.register { SecureStorage() }
            .implements(SecureStorageProtocol.self)
            .scope(.application)

        container.register { NetworkClient(secureStorage: container.resolve(), baseUrl: self.baseUrl) }
            .scope(.application)

        container.register { LoginNetworkClient(networkClient: container.resolve()) }
            .implements(LoginNetworkClientProtocol.self)
            .scope(.application)

        container.register { CheckNetworkClient(networkClient: container.resolve()) }
            .implements(CheckNetworkClientProtocol.self)
            .scope(.application)

        container.register { UserNetworkClient(networkClient: container.resolve()) }
            .implements(UserNetworkClientProtocol.self)
            .scope(.application)

        container.register { QuizNetworkClient(networkClient: container.resolve()) }
            .implements(QuizNetworkClientProtocol.self)
            .scope(.application)

        container.register { UserNetworkDataSource(
            loginNetworkClient: container.resolve(),
            checkNetworkClient: container.resolve(),
            userNetworkClient: container.resolve())
        }
        .implements(UserNetworkDataSourceProtocol.self)
        .scope(.application)

        container.register { QuizNetworkDataSource(quizNetworkClient: container.resolve()) }
            .implements(QuizNetworkDataSourceProtocol.self)
            .scope(.application)

        container.register { UserDatabaseDataSource(secureStorage: container.resolve()) }
            .implements(UserDatabaseDataSourceProtocol.self)
            .scope(.application)

        container.register {
            UserRepository(
                userNetworkDataSource: container.resolve(),
                userDatabaseDataSource: container.resolve())
        }
        .implements(UserRepositoryProtocol.self)
        .scope(.application)

        container.register { QuizRepository(quizNetworkDataSource: container.resolve()) }
            .implements(QuizRepositoryProtocol.self)
            .scope(.application)

        container.register { LoginUseCase(userRepository: container.resolve()) }
            .implements(LoginUseCaseProtocol.self)
            .scope(.application)

        container.register { UserUseCase(userRepository: container.resolve()) }
            .implements(UserUseCaseProtocol.self)
            .scope(.application)

        container.register { LogOutUseCase(userRepository: container.resolve()) }
            .implements(LogOutUseCaseProtocol.self)
            .scope(.application)

        container.register { QuizUseCase(quizRepository: container.resolve()) }
            .implements(QuizUseCaseProtocol.self)
            .scope(.application)
    }
}

extension Resolver: ResolverRegistering {

    public static func registerAllServices() {
        defaultScope = .application

    }

}

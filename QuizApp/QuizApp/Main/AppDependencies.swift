import Resolver

extension Resolver: ResolverRegistering {

    static let dependencies = Resolver()

    public static func registerAllServices() {

        defaultScope = .application

        register { SecureStorage() }
            .implements(SecureStorageProtocol.self)

        register { NetworkClient(secureStorage: resolve(), baseUrl: "https://five-ios-quiz-app.herokuapp.com/api") }

        register { LoginNetworkClient(networkClient: resolve()) }
            .implements(LoginNetworkClientProtocol.self)

        register { CheckNetworkClient(networkClient: resolve()) }
            .implements(CheckNetworkClientProtocol.self)

        register { UserNetworkClient(networkClient: resolve()) }
            .implements(UserNetworkClientProtocol.self)

        register { QuizNetworkClient(networkClient: resolve()) }
            .implements(QuizNetworkClientProtocol.self)

        register { UserNetworkDataSource(
            loginNetworkClient: resolve(),
            checkNetworkClient: resolve(),
            userNetworkClient: resolve())
        }
        .implements(UserNetworkDataSourceProtocol.self)

        register { QuizNetworkDataSource(quizNetworkClient: resolve()) }
            .implements(QuizNetworkDataSourceProtocol.self)

        register { UserDatabaseDataSource(secureStorage: resolve()) }
            .implements(UserDatabaseDataSourceProtocol.self)

        register {
            UserRepository(
                userNetworkDataSource: resolve(),
                userDatabaseDataSource: resolve())
        }
        .implements(UserRepositoryProtocol.self)

        register { QuizRepository(quizNetworkDataSource: resolve()) }
            .implements(QuizRepositoryProtocol.self)

        register { LoginUseCase(userRepository: resolve()) }
            .implements(LoginUseCaseProtocol.self)

        register { UserUseCase(userRepository: resolve()) }
            .implements(UserUseCaseProtocol.self)

        register { LogOutUseCase(userRepository: resolve()) }
            .implements(LogOutUseCaseProtocol.self)

        register { QuizUseCase(quizRepository: resolve()) }
            .implements(QuizUseCaseProtocol.self)
    }

}

import Resolver
class AppDependencies {

    private let baseUrl = "https://five-ios-quiz-app.herokuapp.com/api"

    lazy var secureStorage = SecureStorage()

    lazy var loginUseCase: LoginUseCaseProtocol = {
        LoginUseCase(userRepository: userRepository)
    }()

    lazy var userUseCase: UserUseCaseProtocol = {
        UserUseCase(userRepository: userRepository)
    }()

    lazy var logoutUseCase: LogOutUseCaseProtocol = {
        LogOutUseCase(userRepository: userRepository)
    }()

    lazy var quizUseCase: QuizUseCaseProtocol = {
        QuizUseCase(quizRepository: quizRepository)
    }()

    lazy var userRepository: UserRepositoryProtocol = {
        UserRepository(userNetworkDataSource: userNetworkDataSource, userDatabaseDataSource: userDatabaseDataSource)
    }()

    lazy var quizRepository: QuizRepositoryProtocol = {
        QuizRepository(quizNetworkDataSource: quizNetworkDataSource)
    }()

    lazy var userNetworkDataSource: UserNetworkDataSourceProtocol = {
        UserNetworkDataSource(
            loginClient: loginNetworkClient,
            checkNetworkClient: checkNetworkClient,
            userNetworkClient: userNetworkClient)
    }()

    lazy var quizNetworkDataSource: QuizNetworkDataSourceProtocol = {
        QuizNetworkDataSource(quizNetworkClient: quizNetworkClient)
    }()

    lazy var userDatabaseDataSource: UserDatabaseDataSourceProtocol = {
        UserDatabaseDataSource(secureStorage: secureStorage)
    }()

    lazy var loginNetworkClient: LoginNetworkClientProtocol = {
        LoginNetworkClient(networkClient: networkClient)
    }()

    lazy var userNetworkClient: UserNetworkClientProtocol = {
        UserNetworkClient(networkClient: networkClient)
    }()

    lazy var checkNetworkClient: CheckNetworkClientProtocol = {
        CheckNetworkClient(networkClient: networkClient)
    }()

    lazy var quizNetworkClient: QuizNetworkClientProtocol = {
        QuizNetworkClient(networkClient: networkClient)
    }()

    lazy var networkClient: NetworkClient = {
        NetworkClient(secureStorage: secureStorage, baseUrl: baseUrl)
    }()

}

extension Resolver: ResolverRegistering {

    public static func registerAllServices() {
        register { LoginUseCase(userRepository: AppDependencies().userRepository) }
            .implements(LoginUseCaseProtocol.self)
    }

}

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

    lazy var userNetworkDataSource: UserNetworkDataSourceProtocol = {
        UserNetworkDataSource(
            loginClient: loginNetworkClient,
            checkNetworkClient: checkNetworkClient,
            userNetworkClient: userNetworkClient)
    }()

    lazy var userDatabaseDataSource: UserDatabaseDataSource = {
        UserDatabaseDataSource(secureStorage: secureStorage)
    }()

    lazy var userRepository: UserRepository = {
        UserRepository(userNetworkDataSource: userNetworkDataSource, userDatabaseDataSource: userDatabaseDataSource)
    }()

    lazy var loginNetworkClient: LoginNetworkClientProtocol = {
        LoginNetworkClient(networkClient: networkClient)
    }()

    lazy var userNetworkClient: UserNetworkClient = {
        UserNetworkClient(networkClient: networkClient)
    }()

    lazy var checkNetworkClient: CheckNetworkClientProtocol = {
        CheckNetworkClient(networkClient: networkClient)
    }()

    lazy var networkClient: NetworkClient = {
        NetworkClient(secureStorage: secureStorage, baseUrl: baseUrl)
    }()

}

class AppDependencies {

    private let baseUrl = "https://five-ios-quiz-app.herokuapp.com/api"

    lazy var loginUseCase: LoginUseCaseProtocol = {
        LoginUseCase(userRepository: userRepository)
    }()

    lazy var userNetworkDataSource: UserNetworkDataSourceProtocol = {
        UserNetworkDataSource(loginClient: loginClient, checkNetworkClient: checkNetworkClient)
    }()

    lazy var userDatabaseDataSource: UserDatabaseDataSource = UserDatabaseDataSource()

    lazy var userRepository: UserRepository = {
        UserRepository(userNetworkDataSource: userNetworkDataSource, userDatabaseDataSource: userDatabaseDataSource)
    }()

    lazy var loginClient: LoginNetworkClientProtocol = {
        LoginNetworkClient(baseUrl: baseUrl)
    }()

    lazy var checkNetworkClient: CheckNetworkClientProtocol = {
        CheckNetworkClient(baseUrl: baseUrl)
    }()

}

class AppDependencies {

    private let baseUrl = "https://five-ios-quiz-app.herokuapp.com/api"

    lazy var loginUseCase: LoginUseCaseProtocol = {
        LoginUseCase(userRepository: userRepository)
    }()

    lazy var userNetworkDataSource: UserNetworkDataSourceProtocol = {
        UserNetworkDataSource(loginClient: loginClient)
    }()

    lazy var userDatabaseDataSource: UserDatabaseDataSource = UserDatabaseDataSource()

    lazy var userRepository: UserRepository = {
        UserRepository(userNetworkDataSource: userNetworkDataSource, userDatabaseDataSource: userDatabaseDataSource)
    }()

    lazy var loginClient: LoginClientProtocol = {
        LoginClient(baseUrl: baseUrl)
    }()

}

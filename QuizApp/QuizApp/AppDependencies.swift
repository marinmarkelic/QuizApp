class AppDependencies {

    private let baseUrl = "https://five-ios-quiz-app.herokuapp.com/api"

    lazy var loginUseCase: LoginUseCaseProtocol = {
        LoginUseCase(userNetworkDataSource: userNetworkDataSource)
    }()

    lazy var userNetworkDataSource: UserNetworkDataSourceProtocol = {
        UserNetworkDataSource(loginClient: loginClient)
    }()

    lazy var loginClient: LoginClientProtocol = {
        LoginClient(baseUrl: baseUrl)
    }()

}

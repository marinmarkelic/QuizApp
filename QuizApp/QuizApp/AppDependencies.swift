class AppDependencies {

    private let baseUrl = "https://five-ios-quiz-app.herokuapp.com/api"

    lazy var loginClient: LoginClientProtocol = {
        LoginClient(baseUrl: baseUrl)
    }()

}

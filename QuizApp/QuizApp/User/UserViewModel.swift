class UserViewModel {

    private let appRouter: AppRouterProtocol
    private let userUseCase: UserUseCaseProtocol
    private let logoutUseCase: LogOutUseCaseProtocol

    init(appRouter: AppRouterProtocol, userUseCase: UserUseCaseProtocol, logoutUseCase: LogOutUseCaseProtocol) {
        self.appRouter = appRouter
        self.userUseCase = userUseCase
        self.logoutUseCase = logoutUseCase
    }

    func save(username: String) {
        userUseCase.save(userInfo: UserInfoModel(username: username))
    }

    var username: String {
        userInfo.username
    }

    var userInfo: UserInfo {
        UserInfo(userUseCase.userInfo)
    }

    func logOut() {
        logoutUseCase.logOut()
        appRouter.showLogin()
    }

}

struct UserInfo {

    let username: String

}

extension UserInfo {

    init(_ userInfo: UserInfoModel) {
        username = userInfo.username
    }

}

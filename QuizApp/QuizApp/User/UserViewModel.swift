class UserViewModel {

    private let appRouter: AppRouterProtocol
    private let userUseCase: UserUseCaseProtocol
    private let logoutUseCase: LogOutUseCaseProtocol

    var username: String {
        userInfo.username
    }

    var userInfo: UserInfo {
        UserInfo(userUseCase.userInfo)
    }

    init(appRouter: AppRouterProtocol, userUseCase: UserUseCaseProtocol, logoutUseCase: LogOutUseCaseProtocol) {
        self.appRouter = appRouter
        self.userUseCase = userUseCase
        self.logoutUseCase = logoutUseCase
    }

    func save(username: String, name: String) {
        userUseCase.save(userInfo: UserInfoModel(username: username, name: name))
    }

    func logOut() {
        logoutUseCase.logOut()
        appRouter.showLogin()
    }

}

struct UserInfo {

    let username: String
    let name: String

}

extension UserInfo {

    init(_ userInfo: UserInfoModel) {
        username = userInfo.username
        name = userInfo.name
    }

}

extension UserInfoModel {

    init(_ userInfo: UserInfo) {
        username = userInfo.username
        name = userInfo.name
    }

}

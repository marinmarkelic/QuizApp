import Combine

class UserViewModel {

    private let appRouter: AppRouterProtocol
    private let userUseCase: UserUseCaseProtocol
    private let logoutUseCase: LogOutUseCaseProtocol

    @Published var userInfo: UserInfo = UserInfo(username: "")

    init(appRouter: AppRouterProtocol, userUseCase: UserUseCaseProtocol, logoutUseCase: LogOutUseCaseProtocol) {
        self.appRouter = appRouter
        self.userUseCase = userUseCase
        self.logoutUseCase = logoutUseCase

        getUserInfo()
    }

    func save(username: String) {
        userUseCase.save(userInfo: UserInfoModel(username: username))
    }

    func logOut() {
        logoutUseCase.logOut()
        appRouter.showLogin()
    }

    func getUserInfo() {
        userInfo = UserInfo(userUseCase.userInfo)
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

extension UserInfoModel {

    init(_ userInfo: UserInfo) {
        username = userInfo.username
    }

}

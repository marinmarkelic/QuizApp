class UserViewModel {

    private let appRouter: AppRouterProtocol
    private let userUseCase: UserUseCaseProtocol

    init(appRouter: AppRouterProtocol, userUseCase: UserUseCaseProtocol) {
        self.appRouter = appRouter
        self.userUseCase = userUseCase
    }

    func save(username: String) {
        userUseCase.save(userInfo: UserInfo(username: username))
    }

    var username: String {
        userInfo.username
    }

    var userInfo: UserInfo {
        UserInfo(userUseCase.userInfo)
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

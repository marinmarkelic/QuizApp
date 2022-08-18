import Foundation

class UserViewModel: ObservableObject {

    var userInfo: UserInfo = UserInfo()

    private var router: AppRouterProtocol!
    private var userUseCase: UserUseCaseProtocol!
    private var logoutUseCase: LogOutUseCaseProtocol!

    init(router: AppRouterProtocol, userUseCase: UserUseCaseProtocol, logoutUseCase: LogOutUseCaseProtocol) {
        self.router = router
        self.userUseCase = userUseCase
        self.logoutUseCase = logoutUseCase
    }

    init() {}

    @MainActor
    func save() {
        Task {
            do {
                let userInfo = try await userUseCase.save(
                    userInfo: UserInfoModel(
                        username: userInfo.username,
                        name: userInfo.name))

                self.userInfo.set(
                    username: userInfo.username,
                    name: userInfo.name)
            } catch _ {}
        }
    }

    @MainActor
    func getUserInfo() {
        Task {
            do {
                let userInfo = try await userUseCase.userInfo
                self.userInfo.set(
                    username: userInfo.username,
                    name: userInfo.name)
            } catch _ {}
        }
    }

    func logOut() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.logoutUseCase.logOut()
            self.router.showLogin()
        }
    }

}

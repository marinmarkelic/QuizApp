import Combine
import Foundation

class UserViewModel {

    private let router: AppRouterProtocol
    private let userUseCase: UserUseCaseProtocol
    private let logoutUseCase: LogOutUseCaseProtocol

    @Published var userInfo: UserInfo = UserInfo()

    init(router: AppRouterProtocol, userUseCase: UserUseCaseProtocol, logoutUseCase: LogOutUseCaseProtocol) {
        self.router = router
        self.userUseCase = userUseCase
        self.logoutUseCase = logoutUseCase
    }

    @MainActor
    func save(username: String, name: String) {
        Task {
            do {
                userInfo = try await UserInfo(userUseCase.save(userInfo: UserInfoModel(username: username, name: name)))
            } catch _ {}
        }
    }

    @MainActor
    func getUserInfo() {
        Task {
            do {
                userInfo = try await UserInfo(userUseCase.userInfo)
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

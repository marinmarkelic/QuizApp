import Combine
import Foundation

class UserViewModel {

    private let appRouter: AppRouterProtocol
    private let userUseCase: UserUseCaseProtocol
    private let logoutUseCase: LogOutUseCaseProtocol

    @Published var userInfo: UserInfo = UserInfo()

    init(appRouter: AppRouterProtocol, userUseCase: UserUseCaseProtocol, logoutUseCase: LogOutUseCaseProtocol) {
        self.appRouter = appRouter
        self.userUseCase = userUseCase
        self.logoutUseCase = logoutUseCase

        getUserInfo()
    }

    func save(username: String, name: String) async {
        do {
            userInfo = try await UserInfo(userUseCase.save(userInfo: UserInfoModel(username: username, name: name)))
        } catch _ {}
    }

    func getUserInfo() {
        Task {
            do {
                userInfo = try await UserInfo(userUseCase.userInfo)
            } catch _ {}
        }
    }

    func logOut() {
        DispatchQueue.main.async { [weak self] in
            self?.logoutUseCase.logOut()
            self?.appRouter.showLogin()
        }
    }

}

struct UserInfo {

    let username: String
    let name: String

}

extension UserInfo {

    init() {
        username = ""
        name = ""
    }

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

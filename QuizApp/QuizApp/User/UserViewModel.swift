import Combine
import Foundation

class UserViewModel {

    private let appRouter: AppRouterProtocol
    private let userUseCase: UserUseCaseProtocol
    private let logoutUseCase: LogOutUseCaseProtocol

    @Published var userInfo: UserInfo = UserInfo(username: "", name: "")

    init(appRouter: AppRouterProtocol, userUseCase: UserUseCaseProtocol, logoutUseCase: LogOutUseCaseProtocol) {
        self.appRouter = appRouter
        self.userUseCase = userUseCase
        self.logoutUseCase = logoutUseCase

        getUserInfo()
    }

    func save(username: String, name: String) async {
        do {
            try await userUseCase.save(userInfo: UserInfoModel(username: username, name: name))
        } catch {
            logOut()
        }
    }

    func getUserInfo() {
        Task {
            do {
                userInfo = try await UserInfo(userUseCase.userInfo)
            } catch {
                logOut()
            }
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

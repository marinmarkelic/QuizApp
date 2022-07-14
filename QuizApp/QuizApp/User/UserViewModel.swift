import Foundation

class UserViewModel {

    private let appRouter: AppRouterProtocol
    private let userUseCase: UserUseCaseProtocol
    private let logoutUseCase: LogOutUseCaseProtocol

    var username: String {
        get async {
            await userInfo?.username ?? ""
        }
    }

    var name: String {
        get async {
            await userInfo?.name ?? ""
        }
    }

    var userInfo: UserInfo? {
        get async {
            do {
                return try await UserInfo(userUseCase.userInfo)
            } catch let error{
                print(error)
                logOut()
            }

            return nil
        }
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

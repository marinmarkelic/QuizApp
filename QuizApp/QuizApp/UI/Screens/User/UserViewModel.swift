import Foundation

class UserViewModel: ObservableObject {

    var userInfo: UserInfo = UserInfo()

    private var userUseCase: UserUseCaseProtocol!
    private var logoutUseCase: LogOutUseCaseProtocol!

    init(userUseCase: UserUseCaseProtocol, logoutUseCase: LogOutUseCaseProtocol) {
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

                self.userInfo.apply(userInfo)
            } catch _ {}
        }
    }

    @MainActor
    func getUserInfo() {
        guard let userUseCase = userUseCase else { return }

        Task {
            do {
                let userInfo = try await userUseCase.userInfo
                self.userInfo.apply(userInfo)
            } catch _ {}
        }
    }

    func logOut() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.logoutUseCase.logOut()
        }
    }

}

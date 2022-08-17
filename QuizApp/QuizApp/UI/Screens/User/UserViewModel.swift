import Combine
import Foundation

class UserViewModel: ObservableObject {

    @Published var userInfo: UserInfo = UserInfo()

    @Published var username: String = ""
    @Published var name: String = ""

    private var router: AppRouterProtocol!
    private var userUseCase: UserUseCaseProtocol!
    private var logoutUseCase: LogOutUseCaseProtocol!

    private var cancellables = Set<AnyCancellable>()

    init(router: AppRouterProtocol, userUseCase: UserUseCaseProtocol, logoutUseCase: LogOutUseCaseProtocol) {
        self.router = router
        self.userUseCase = userUseCase
        self.logoutUseCase = logoutUseCase

        Task {
            await getUserInfo()
        }
        bindViewModel()
    }

    init() {}

    private func bindViewModel() {
        $name
            .removeDuplicates()
            .sink { [weak self] name in
                print(name)
            }
            .store(in: &cancellables)
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
                username = userInfo.username
                name = userInfo.name
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

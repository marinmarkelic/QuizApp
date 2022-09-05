import SwiftUI

class ContentViewModel: ObservableObject {

    private let dataSource: UserNetworkDataSourceProtocol
    private let secureStorage: SecureStorageProtocol

    @Published var isLoggedIn: Bool?

    init(dataSource: UserNetworkDataSourceProtocol, secureStorage: SecureStorageProtocol) {
        self.dataSource = dataSource
        self.secureStorage = secureStorage
    }

    @MainActor
    func checkLoginStatus(appData: AppData) {
        appData.loginStatus = .unknown

        Task {
            do {
                try await dataSource.check()
                appData.loginStatus = .loggedIn
            } catch {
                secureStorage.deleteAccessToken()
                appData.loginStatus = .loggedOut
            }
        }
    }

}

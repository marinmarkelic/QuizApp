import SwiftUI

class AppData: ObservableObject {

    @Published var loginStatus: LoginStatus = .unknown
    @Published var selectedTab: AppRoute = .quizzes

}

enum LoginStatus {

    case unknown
    case notLoggedIn
    case loggedIn

}

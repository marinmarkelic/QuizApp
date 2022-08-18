import Combine

class UserInfo: ObservableObject {

    @Published var username: String = ""
    @Published var name: String = ""

}

extension UserInfo {

    func apply(_  model: UserInfoModel) {
        username = model.username
        name = model.name
    }

}

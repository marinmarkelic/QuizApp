import Combine

class UserInfo: ObservableObject {

    @Published var username: String = ""
    @Published var name: String = ""

    func set(username: String, name: String) {
        self.username = username
        self.name = name
    }

}

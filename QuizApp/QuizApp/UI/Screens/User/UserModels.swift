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

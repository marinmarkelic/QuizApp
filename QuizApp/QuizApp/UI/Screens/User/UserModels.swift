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

struct UserInfoNetworkDataModel: Decodable {

    let id: Int
    let email: String
    let name: String

}

struct UserInfoNetworkRequestModel: Encodable {

    let name: String

}

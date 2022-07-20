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

struct UserInfoModel {

    let username: String
    let name: String

}

extension UserInfoModel {

    init(_ userInfo: UserInfoRepoModel) {
        username = userInfo.username
        name = userInfo.name
    }

}

extension UserInfoRepoModel {

    init(_ userInfo: UserInfoModel) {
        username = userInfo.username
        name = userInfo.name
    }

}

struct UserInfoRepoModel {

    let username: String
    let name: String

}

extension UserInfoRepoModel {

    init(_ userInfo: UserInfoDataModel) {
        username = userInfo.email
        name = userInfo.name
    }

}

struct UserInfoDataModel {

    let id: Int
    let email: String
    let name: String

}

extension UserInfoDataModel {

    init(_ userData: UserInfoNetworkDataModel) {
        email = userData.email
        id = userData.id
        name = userData.name
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

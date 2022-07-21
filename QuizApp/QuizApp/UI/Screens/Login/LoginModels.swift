struct LoginResponseModel {

    let accessToken: String

}

extension LoginResponseModel {

    init(_ loginResponse: LoginResponseRepoModel) {
        accessToken = loginResponse.accessToken
    }

}

struct LoginResponseRepoModel {

    var accessToken: String

}

extension LoginResponseRepoModel {

    init(_ responseDataModel: LoginResponseDataModel) {
        accessToken = responseDataModel.accessToken
    }

}

struct LoginResponseDataModel: Decodable {

    let accessToken: String

}

extension LoginResponseDataModel {

    init(_ loginResponse: LoginResponse) {
        accessToken = loginResponse.accessToken
    }

}

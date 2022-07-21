struct LoginResponseModel {

    let accessToken: String

}

extension LoginResponseModel {

    init(_ loginResponse: LoginResponseRepoModel) {
        accessToken = loginResponse.accessToken
    }

}

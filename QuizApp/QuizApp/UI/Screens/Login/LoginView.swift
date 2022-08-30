import SwiftUI

struct LoginView: View {

    @EnvironmentObject var shared: Shared

    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        VStack {
            Text("PopQuiz")
                .font(.heading1)
                .foregroundColor(.white)

            Spacer()

            UserInputView(
                username: $viewModel.email,
                password: $viewModel.password,
                errorText: viewModel.errorText,
                isLoginButtonEnabled: viewModel.isLoginButtonEnabled)
            .onLoginTap {
                viewModel.pressedLoginButton { value in
                    shared.loginStatus = value ? .loggedIn : .notLoggedIn
                }
            }

            Spacer()
        }
        .background(LinearGradient.background.ignoresSafeArea())
    }

}

struct LoginView_Previews: PreviewProvider {

    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }

}

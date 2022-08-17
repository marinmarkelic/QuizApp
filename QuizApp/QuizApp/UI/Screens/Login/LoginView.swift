import SwiftUI

struct LoginView: View {

    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        VStack {
            Text("PopQuiz")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Spacer()

            UserInputView(
                username: $viewModel.email,
                password: $viewModel.password,
                errorText: viewModel.errorText,
                isLoginButtonEnabled: viewModel.isLoginButtonEnabled)
                .onLoginTap {
                    viewModel.pressedLoginButton()
                }

            Spacer()
        }
        .background(GradientBackground())
    }

}

struct LoginView_Previews: PreviewProvider {

    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }

}

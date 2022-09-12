import SwiftUI

struct LoginView: View {

    @EnvironmentObject var appData: AppData

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
                viewModel.pressedLoginButton(appData: appData, isLoginLoadingShowed: $0)
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

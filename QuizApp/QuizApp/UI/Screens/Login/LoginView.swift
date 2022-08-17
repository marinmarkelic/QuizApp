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

struct CustomTextField: View {

    let placeholder: String
    let isSecure: Bool
    let text: Binding<String>

    @State private var isVisible: Bool = false

    init(placeholder: String, isSecure: Bool, text: Binding<String>) {
        self.placeholder = placeholder
        self.isSecure = isSecure
        self.text = text
    }

    var body: some View {
        ZStack {
            if isSecure && !isVisible {
                SecureField("", text: text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundColor(.white)
                    .padding()
                    .background(.white.opacity(0.3))
                    .cornerRadius(25)
                    .frame(height: 50, alignment: .center)
            } else {
                TextField("", text: text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundColor(.white)
                    .padding()
                    .background(.white.opacity(0.3))
                    .cornerRadius(25)
                    .frame(height: 50, alignment: .center)
            }

            if text.wrappedValue.isEmpty {
                HStack {
                    Text(placeholder)
                        .padding(.leading)
                        .foregroundColor(.white.opacity(0.7))
                        .allowsHitTesting(false)
                    Spacer()
                }
            } else if isVisible || isSecure {
                HStack {
                    let imageName = isVisible ? "eye.fill" : "eye"

                    Spacer()
                    Image(systemName: imageName)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.trailing)
                        .onTapGesture {
                            isVisible = !isVisible
                        }
                }
            }
        }
    }

}

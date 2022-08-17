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

            UserInfoView(
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

struct UserInfoView: View {

    let username: Binding<String>
    let password: Binding<String>
    let errorText: String
    let isLoginButtonEnabled: Bool
    let onLoginTap: () -> Void

    init(
        username: Binding<String>,
        password: Binding<String>,
        errorText: String,
        isLoginButtonEnabled: Bool,
        onLoginTap: @escaping () -> Void = { }
    ) {
        self.username = username
        self.password = password
        self.errorText = errorText
        self.isLoginButtonEnabled = isLoginButtonEnabled
        self.onLoginTap = onLoginTap
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            CustomTextField(placeholder: "Username", isSecure: false, text: username)
            CustomTextField(placeholder: "Password", isSecure: true, text: password)

            if !errorText.isEmpty {
                Text(errorText)
                    .lineLimit(nil)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            }

            Button(action: { onLoginTap() }, label: {
                Text("Login")
                    .foregroundColor(Color(red: 0.39, green: 0.16, blue: 0.87)) // change
                    .frame(maxWidth: .infinity)
            })
            .disabled(!isLoginButtonEnabled)
            .padding()
            .background(isLoginButtonEnabled ? .white : .white.opacity(0.7))
            .cornerRadius(25)
            .padding(.top)
        }
        .padding()
    }

    func onLoginTap(_ onLoginTap: @escaping () -> Void) -> UserInfoView {
        UserInfoView(
            username: username,
            password: password,
            errorText: errorText,
            isLoginButtonEnabled: isLoginButtonEnabled,
            onLoginTap: onLoginTap)
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

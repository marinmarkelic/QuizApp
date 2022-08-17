import SwiftUI

struct UserInputView: View {

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

    func onLoginTap(_ onLoginTap: @escaping () -> Void) -> UserInputView {
        UserInputView(
            username: username,
            password: password,
            errorText: errorText,
            isLoginButtonEnabled: isLoginButtonEnabled,
            onLoginTap: onLoginTap)
    }

}

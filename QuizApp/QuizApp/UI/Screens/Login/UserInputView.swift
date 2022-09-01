import SwiftUI

struct UserInputView: View {

    let username: Binding<String>
    let password: Binding<String>
    let errorText: String
    let isLoginButtonEnabled: Bool
    let onLoginTap: () -> Void

    @State private var isErrorTextShown: Bool = false

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
            if isErrorTextShown {
                Text(isErrorTextShown ? " " : "")
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .opacity(0)
                    .animation(.easeOut, value: isErrorTextShown)
            }

            RoundedTextField(placeholder: "Username", isSecure: false, text: username)

            RoundedTextField(placeholder: "Password", isSecure: true, text: password)

            if isErrorTextShown {
                Text(errorText)
                    .lineLimit(nil)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .animation(.easeOut, value: isErrorTextShown)
            }

            Button(action: { onLoginTap() }, label: {
                Text("Login")
                    .foregroundColor(.purpleText)
                    .font(.heading6)
                    .frame(maxWidth: .infinity)
            })
            .disabled(!isLoginButtonEnabled)
            .padding()
            .background(isLoginButtonEnabled ? .white : .white.opacity(0.7))
            .cornerRadius(25)
            .padding(.top)
        }
        .padding()
        .onChange(of: errorText) { text in
            withAnimation {
                // This is needed because we set ErrorText to " " when there is no error
                // to make the animation smooth
                isErrorTextShown = !text.trimmingCharacters(in: .whitespaces).isEmpty
            }
        }

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

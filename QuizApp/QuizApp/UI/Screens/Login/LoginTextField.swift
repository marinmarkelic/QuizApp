import SwiftUI

struct LoginTextField: View {

    let placeholder: String
    let isSecure: Bool

    @Binding var text: String

    @State private var isVisible: Bool = false

    var body: some View {
        ZStack {
            if isSecure && !isVisible {
                SecureField("", text: $text)
                    .styleForLogin()
            } else {
                TextField("", text: $text)
                    .styleForLogin()
            }

            if text.isEmpty {
                HStack {
                    Text(placeholder)
                        .font(.body1)
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

extension SecureField {

    func styleForLogin() -> some View {
        self
            .font(.body1)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .foregroundColor(.white)
            .padding()
            .background(.white.opacity(0.3))
            .cornerRadius(25)
            .frame(height: 50, alignment: .center)
    }

}

extension TextField {

    func styleForLogin() -> some View {
        self
            .font(.body1)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .foregroundColor(.white)
            .padding()
            .background(.white.opacity(0.3))
            .cornerRadius(25)
            .frame(height: 50, alignment: .center)
    }

}

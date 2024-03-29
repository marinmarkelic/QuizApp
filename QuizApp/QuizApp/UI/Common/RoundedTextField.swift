import SwiftUI

struct RoundedTextField: View {

    let placeholder: String
    let isSecure: Bool

    @Binding var text: String

    @State private var isVisible: Bool = false

    var body: some View {
        ZStack {
            if isSecure && !isVisible {
                SecureField("", text: $text)
                    .loginStyle()
            } else {
                TextField("", text: $text)
                    .loginStyle()
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
                            isVisible.toggle()
                        }
                }
            }
        }
    }

}

extension SecureField {

    func loginStyle() -> some View {
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

    func loginStyle() -> some View {
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

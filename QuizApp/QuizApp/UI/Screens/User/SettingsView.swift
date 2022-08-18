import SwiftUI

struct SettingsView: View {

    @ObservedObject var viewModel: UserViewModel

    var body: some View {
        return VStack(alignment: .leading) {
            UserInfoView(
                username: viewModel.username,
                name: $viewModel.name)
            .onLogoutTap {
                viewModel.logOut()
            }

            Spacer()
        }.background(LinearGradient.background.ignoresSafeArea())
    }

}

struct SettingsView_Previews: PreviewProvider {

    static var previews: some View {
        SettingsView(viewModel: UserViewModel())
    }

}

struct UserInfoView: View {

    let username: String
    let name: Binding<String>
    let onLogoutTap: () -> Void

    init(username: String, name: Binding<String>, onLogoutTap: @escaping () -> Void = {}) {
        self.username = username
        self.name = name
        self.onLogoutTap = onLogoutTap
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("USERNAME")
                    .font(.subtitle4)
                    .foregroundColor(.white)
                    .padding(.top, 40)

                TextField("", text: Binding.constant(username))
                    .font(.heading4)
                    .foregroundColor(.white)
                    .disabled(true)

                Text("NAME")
                    .font(.subtitle4)
                    .foregroundColor(.white)
                    .padding(.top, 40)

                TextField("", text: name)
                    .font(.heading4)
                    .foregroundColor(.white)

                Spacer()

                Button(action: { onLogoutTap() }, label: {
                    Text("LogOut")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                })
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(25)

            }
            .padding()

            Spacer()
        }
    }

    func onLogoutTap(_ onLogoutTap: @escaping () -> Void) -> UserInfoView {
        UserInfoView(
            username: username,
            name: name,
            onLogoutTap: onLogoutTap)
    }

}

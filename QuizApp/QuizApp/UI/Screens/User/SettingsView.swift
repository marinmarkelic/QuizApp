import SwiftUI

struct SettingsView: View {

    @ObservedObject var viewModel: UserViewModel

    var body: some View {
        VStack(alignment: .leading) {
            UserInfoView(
                userInfo: viewModel.userInfo)
            .onLogoutTap {
                viewModel.logOut()
            }
            .onNameChange {
                viewModel.save()
            }
            .onAppear {
                viewModel.getUserInfo()
            }

            Spacer()
        }
        .background(LinearGradient.background.ignoresSafeArea())
    }

}

struct SettingsView_Previews: PreviewProvider {

    static var previews: some View {
        SettingsView(viewModel: UserViewModel())
    }

}

struct UserInfoView: View {

    let onLogoutTap: () -> Void
    let onNameChange: () -> Void

    @ObservedObject var userInfo: UserInfo

    init(userInfo: UserInfo, onLogoutTap: @escaping () -> Void = {}, onNameChange: @escaping () -> Void = {}) {
        self.userInfo = userInfo
        self.onLogoutTap = onLogoutTap
        self.onNameChange = onNameChange
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("USERNAME")
                    .font(.subtitle4)
                    .foregroundColor(.white)
                    .padding(.top, 40)

                TextField("", text: $userInfo.username)
                    .font(.heading4)
                    .foregroundColor(.white)
                    .disabled(true)

                Text("NAME")
                    .font(.subtitle4)
                    .foregroundColor(.white)
                    .padding(.top, 40)

                TextField("", text: $userInfo.name, onCommit: { onNameChange() })
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
            userInfo: userInfo,
            onLogoutTap: onLogoutTap)
    }

    func onNameChange(_ onNameChange: @escaping () -> Void) -> UserInfoView {
        UserInfoView(
            userInfo: userInfo,
            onNameChange: onNameChange)
    }

}

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

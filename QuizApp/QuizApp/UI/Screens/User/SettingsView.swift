import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var shared: Shared

    @ObservedObject var viewModel: UserViewModel

    var body: some View {
        VStack(alignment: .leading) {
            UserInfoView(
                userInfo: viewModel.userInfo)
            .onLogoutTap {
                viewModel.logOut()
                shared.loginStatus = .unknown
            }
            .onNameChange {
                viewModel.save()
            }

            Spacer()
        }
        .background(LinearGradient.background.ignoresSafeArea())
        .onAppear {
            viewModel.getUserInfo()
        }
    }

}

struct SettingsView_Previews: PreviewProvider {

    static var previews: some View {
        SettingsView(viewModel: UserViewModel())
    }

}

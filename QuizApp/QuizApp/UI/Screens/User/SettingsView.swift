import SwiftUI

struct SettingsView: View {

    var body: some View {
        VStack(alignment: .leading) {
            UserInfoView()

            Spacer()
        }.background(LinearGradient.background.ignoresSafeArea())
    }

}

struct SettingsView_Previews: PreviewProvider {

    static var previews: some View {
        SettingsView()
    }

}

struct UserInfoView: View {

    let username: String
    let name: Binding<String>

    init(username: String, name: Binding<String>) {
        self.username = username
        self.name = name
    }

    init() {
        username = "Username"
        name = Binding.constant("name")
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

                Button(action: {} ) {
                    Text("LogOut")
                        .foregroundColor(.red)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(25)

            }.padding()

            Spacer()
        }
    }

}

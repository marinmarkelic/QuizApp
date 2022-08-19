import SwiftUI

struct SearchBar: View {

    @Binding var text: String

    var body: some View {
        HStack {
            RoundedTextField(placeholder: "Type here", isSecure: false, text: $text)

            Text("Search")
                .font(.heading6)
                .foregroundColor(.white)
        }
    }

}

import SwiftUI

struct SearchBar: View {

    @Binding var text: String

    @FocusState var isTextFieldFocused: Bool

    var onSearchTap: () -> Void = {}

    var body: some View {
        HStack {
            RoundedTextField(placeholder: "Type here", isSecure: false, text: $text)
                .focused($isTextFieldFocused)

            Text("Search")
                .font(.heading6)
                .foregroundColor(.white)
                .onTapGesture {
                    onSearchTap()
                    isTextFieldFocused = false
                }
        }
    }

    func onSearchTap(_ onSearchTap: @escaping () -> Void) -> SearchBar {
        SearchBar(text: $text, onSearchTap: onSearchTap)
    }

}

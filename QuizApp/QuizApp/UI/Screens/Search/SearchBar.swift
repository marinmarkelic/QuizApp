import SwiftUI

struct SearchBar: View {

    @FocusState var isTextFieldFocused: Bool

    var text: Binding<String>
    var onSearchTap: () -> Void

    init(text: Binding<String>, onSearchTap: @escaping () -> Void = {}) {
        self.text = text
        self.onSearchTap = onSearchTap
    }

    var body: some View {
        HStack {
            RoundedTextField(placeholder: "Type here", isSecure: false, text: text)
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
        SearchBar(text: text, onSearchTap: onSearchTap)
    }

}

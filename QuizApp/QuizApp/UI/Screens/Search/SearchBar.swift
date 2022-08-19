import SwiftUI

struct SearchBar: View {

    @Binding var text: String

    var onSearchTap: () -> Void = {}

    var body: some View {
        HStack {
            RoundedTextField(placeholder: "Type here", isSecure: false, text: $text)

            Text("Search")
                .font(.heading6)
                .foregroundColor(.white)
                .onTapGesture {
                    onSearchTap()
                }
        }
    }

}

extension SearchBar {

    func onSearchTap(_ onSearchTap: @escaping () -> Void) -> SearchBar {
        SearchBar(text: $text, onSearchTap: onSearchTap)
    }

}

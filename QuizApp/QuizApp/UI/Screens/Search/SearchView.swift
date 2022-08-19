import SwiftUI

struct SearchView: View {

    @State var text = ""

    var body: some View {
        VStack {
            content
                .padding()
        }
        .maxWidth()
        .background(LinearGradient.background.ignoresSafeArea())
    }

    private var content: some View {
        HStack {
            LoginTextField(placeholder: "Type here", isSecure: false, text: $text)

            Text("Search")
                .font(.heading6)
                .foregroundColor(.white)
        }
        .pushedUp()
    }

}

struct SearchPreview: PreviewProvider {

    static var previews: some View {
        SearchView()
    }

}

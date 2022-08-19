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
        SearchBar()
        .pushedUp()
    }

}

struct SearchPreview: PreviewProvider {

    static var previews: some View {
        SearchView()
    }

}

import SwiftUI

struct SearchView: View {

    @ObservedObject var viewModel: SearchViewModel

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
        SearchBar(text: $text)
        .pushedUp()
    }

}

struct SearchPreview: PreviewProvider {

    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }

}

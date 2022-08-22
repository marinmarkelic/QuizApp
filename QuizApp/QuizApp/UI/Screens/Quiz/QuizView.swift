import SwiftUI

struct QuizView: View {

    var body: some View {
        VStack {
            CategorySlider()
                .onCategoryTap {
                    print($0)
                }
        }
        .maxWidth()
        .maxHeight()
        .background(LinearGradient.background.ignoresSafeArea())

    }

}

struct QuizViewPreview: PreviewProvider {

    static var previews: some View {
        QuizView()
    }

}

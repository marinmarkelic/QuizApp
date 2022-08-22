import SwiftUI

struct QuizView: View {

    var body: some View {
        VStack {
            Slider()
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

struct Slider: View {

    var onCategoryTap: (Category) -> Void

    private var categories = CategoryType.allCases.map { Category(from: $0) }

    init(onCategoryTap: @escaping (Category) -> Void = { _ in }) {
        self.onCategoryTap = onCategoryTap
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(categories, id: \.index) { category in
                    Text(category.name)
                        .font(.heading4)
                        .foregroundColor(Color(category.color))
                        .onTapGesture {
                            onCategoryTap(category)
                        }
                }
            }
        }
    }

    func onCategoryTap(onCategoryTap: @escaping (Category) -> Void) -> Slider {
        Slider(onCategoryTap: onCategoryTap)
    }

}

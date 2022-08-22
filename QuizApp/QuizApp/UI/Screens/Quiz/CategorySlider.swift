import SwiftUI

struct CategorySlider: View {

    let categories: [Category]
    let onCategoryTap: (Category) -> Void

    init(categories: [Category], onCategoryTap: @escaping (Category) -> Void = { _ in }) {
        self.categories = categories
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

    func onCategoryTap(onCategoryTap: @escaping (Category) -> Void) -> CategorySlider {
        CategorySlider(categories: categories, onCategoryTap: onCategoryTap)
    }

}

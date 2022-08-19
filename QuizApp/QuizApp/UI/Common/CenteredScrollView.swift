import SwiftUI

// This is used to achieve a vertical ScrollView with vertically centered content

struct CenteredScrollView<Content>: View where Content: View {

    private let axes: Axis.Set
    private let showsIndicators: Bool
    private let content: Content

    init(_ axes: Axis.Set = .vertical, showsIndicators: Bool = true, @ViewBuilder content: () -> Content) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(axes, showsIndicators: showsIndicators) {
                content
                    .frame(width: geometry.size.width)
                    .frame(minHeight: geometry.size.height)
            }
        }
    }

}

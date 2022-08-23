import SwiftUI

extension View {

    // MARK: - Resizing
    func maxWidth(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
    }

    func maxHeight(alignment: Alignment = .center) -> some View {
        frame(maxHeight: .infinity, alignment: alignment)
    }

    func maxSize(alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }

    // MARK: - Pushing
    func pushedLeft() -> some View {
        HStack(spacing: 0) {
            self

            Spacer()
        }
    }

    func pushedRight() -> some View {
        HStack(spacing: 0) {
            Spacer()

            self
        }
    }

    func pushedUp() -> some View {
        VStack(spacing: 0) {
            self

            Spacer()
        }
    }

    func pushedDown() -> some View {
        VStack(spacing: 0) {
            Spacer()

            self
        }
    }

}

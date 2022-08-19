import SwiftUI

extension View {

    // MARK: - Resizing
    func maxWidth(_ value: CGFloat) -> some View {
        self
            .frame(maxWidth: value)
    }

    func maxHeight(_ value: CGFloat) -> some View {
        self
            .frame(maxHeight: value)
    }

    func minWidth(_ value: CGFloat) -> some View {
        self
            .frame(minWidth: value)
    }

    func minHeight(_ value: CGFloat) -> some View {
        self
            .frame(minHeight: value)
    }

    // MARK: - Pushing
    func pushedLeft() -> some View {
        HStack {
            self

            Spacer()
        }
    }

    func pushedRight() -> some View {
        HStack {
            Spacer()

            self
        }
    }

    func pushedUp() -> some View {
        VStack {
            self

            Spacer()
        }
    }

    func pushedDown() -> some View {
        VStack {
            Spacer()

            self
        }
    }

}

import SwiftUI

extension View {

    // MARK: - Resizing
    func maxWidth() -> some View {
        frame(maxWidth: .infinity)
    }

    func maxHeight() -> some View {
        frame(maxHeight: .infinity)
    }

    func maxSize() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity)
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

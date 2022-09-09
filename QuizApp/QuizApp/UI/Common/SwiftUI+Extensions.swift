import SwiftUI
import UIPilot

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

    // MARK: - Navigation
    func navigationBarTitle(_ title: String) -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(title)
            .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(alignment: .center) {
                    Text(title).font(.heading1)
                }
            }
        }
    }

    // MARK: Navigation bar
    func addChevronBackButton<RouteStruct: Equatable>(_ pilot: UIPilot<RouteStruct>) -> some View {
        self.navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Image(systemName: "chevron.left")
                .onTapGesture { pilot.pop() }
            ,
            trailing: EmptyView())
    }

    func addXBackButton<RouteStruct: Equatable>(_ pilot: UIPilot<RouteStruct>) -> some View {
        self.navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: EmptyView()
            ,
            trailing:
                Image(systemName: "xmark")
                .onTapGesture { pilot.pop() })
    }

}

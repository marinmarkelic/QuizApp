import SwiftUI

struct CircularLoadingView: View {

    var color: Color = .white

    @State private var toggleAnimation: Bool = false

    var body: some View {
        VStack {
            Spacer()

            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(color, lineWidth: 2)
                .frame(width: 20, height: 20)
                .rotationEffect(Angle(degrees: toggleAnimation ? 360 : 0))
                .animation(.linear.repeatForever(autoreverses: false), value: toggleAnimation)

            Spacer()
        }
        .onAppear {
            toggleAnimation.toggle()
        }
    }

}

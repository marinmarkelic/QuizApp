import SwiftUI

struct CircularLoadingView: View {

    @State private var toggleAnimation: Bool = false

    var body: some View {
        VStack {
            Spacer()

            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(.white, lineWidth: 2)
                .frame(width: 20, height: 20)
                .rotationEffect(Angle(degrees: toggleAnimation ? 360 : 0))
                .animation(.linear.repeatForever(autoreverses: false), value: toggleAnimation)

            Spacer()
        }
        .maxSize()
        .background(LinearGradient.background.ignoresSafeArea())
        .onAppear {
            toggleAnimation.toggle()
        }
    }

}

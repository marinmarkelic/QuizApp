import SwiftUI

struct CircularLoadingView: View {

    @State private var toggleAnimation: Bool = false

    var radius: Double = 10

    var body: some View {
        VStack {
            Spacer()

            ZStack {
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(.white, lineWidth: 2)
                    .frame(width: 15, height: 15)
                    .rotationEffect(Angle(degrees: toggleAnimation ? 360 : 0))
                    .animation(.easeInOut.repeatForever(autoreverses: false), value: toggleAnimation)
            }

            Spacer()
        }
        .maxSize()
        .background(LinearGradient.background.ignoresSafeArea())
        .onAppear {
            toggleAnimation.toggle()
        }
    }

}
import SwiftUI

struct LoadingView: View {

    @State private var toggleAnimation: Bool = false

    let numberOfCircles: Int
    let animationDuration: Double

    private var animationDelay: Double {
        animationDuration / 3
    }

    var body: some View {
        VStack {
            Spacer()

            HStack {
                ForEach(0..<numberOfCircles, id: \.self) { index in
                    Circle()
                        .fill(.white)
                        .frame(width: 20, height: 20, alignment: .trailing)
                        .scaleEffect(toggleAnimation ? 1.1 : 0.6)
                        .animation(
                            .easeInOut(duration: animationDuration)
                            .repeatForever(autoreverses: true)
                            .delay(animationDelay * Double(index)),
                            value: toggleAnimation)
                }
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

import SwiftUI

struct GradientBackground: View {

    var body: some View {
        LinearGradient(
            colors: [
                Color(red: 0.45, green: 0.31, blue: 0.64),
                Color(red: 0.15, green: 0.19, blue: 0.46)],
            startPoint: .top,
            endPoint: .bottom)
        .ignoresSafeArea()
    }

}

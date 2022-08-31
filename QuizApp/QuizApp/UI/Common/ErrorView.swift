import SwiftUI

struct ErrorView: View {

    let message: String

    var body: some View {
        VStack {
            Spacer()

            Image(systemName: "multiply.circle")
                .resizable()
                .frame(width: 65, height: 65, alignment: .center)

            Text("Error")
                .font(.heading2)
                .foregroundColor(.white)

            Text(message)
                .font(.body2)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            Spacer()
        }
    }

}

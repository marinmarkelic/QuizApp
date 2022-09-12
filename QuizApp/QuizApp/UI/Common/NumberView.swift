import SwiftUI

struct NumberView: AnimatableModifier {

    var number: Int
    var postfix: String = ""

    var animatableData: Double {
        get { Double(number) }
        set { number = Int(newValue) }
    }

    func body(content: Content) -> some View {
        Text("\(number)\(postfix)")
            .font(.score)
            .foregroundColor(.white)
    }

}

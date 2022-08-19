import SwiftUI

struct QuizListDifficultyView: View {

    var difficulty: Difficulty
    var uiColor: UIColor

    var color: Color {
        Color(uiColor: uiColor)
    }

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "square.fill")
                .resizable()
                .foregroundColor(difficulty.level >= 1 ? color : .white.opacity(0.3))
                .frame(maxWidth: 12, maxHeight: 12)
                .rotationEffect(Angle.degrees(45))

            Image(systemName: "square.fill")
                .resizable()
                .foregroundColor(difficulty.level >= 2 ? color : .white.opacity(0.3))
                .frame(maxWidth: 12, maxHeight: 12)
                .rotationEffect(Angle.degrees(45))

            Image(systemName: "square.fill")
                .resizable()
                .foregroundColor(difficulty.level >= 3 ? color : .white.opacity(0.3))
                .frame(maxWidth: 12, maxHeight: 12)
                .rotationEffect(Angle.degrees(45))
        }
    }

}

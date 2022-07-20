import UIKit

class DifficultyView: UIView {

    private var square1: UIImageView!
    private var square2: UIImageView!
    private var square3: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(difficulty: Difficulty, color: UIColor) {
        switch difficulty {
        case .easy:
            square1.tintColor = color
            square2.tintColor = .white.withAlphaComponent(0.3)
            square3.tintColor = .white.withAlphaComponent(0.3)
        case .normal:
            square1.tintColor = color
            square2.tintColor = color
            square3.tintColor = .white.withAlphaComponent(0.3)
        case .hard:
            square1.tintColor = color
            square2.tintColor = color
            square3.tintColor = color
        }
    }

}

extension DifficultyView: ConstructViewsProtocol {

    func createViews() {
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        let square = UIImage(systemName: "square.fill", withConfiguration: configuration)

        square1 = UIImageView(image: square)
        addSubview(square1)

        square2 = UIImageView(image: square)
        addSubview(square2)

        square3 = UIImageView(image: square)
        addSubview(square3)
    }

    func styleViews() {
        let radians = 45.degreesToRadians

        square1.transform = CGAffineTransform(rotationAngle: radians)
        square2.transform = CGAffineTransform(rotationAngle: radians)
        square3.transform = CGAffineTransform(rotationAngle: radians)
    }

    func defineLayoutForViews() {
        square1.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }

        square2.snp.makeConstraints {
            $0.leading.equalTo(square1.snp.trailing).offset(5)
            $0.top.equalToSuperview()
        }

        square3.snp.makeConstraints {
            $0.leading.equalTo(square2.snp.trailing).offset(5)
            $0.top.trailing.equalToSuperview()
        }
    }

}

extension BinaryInteger {

    var degreesToRadians: CGFloat { CGFloat(self) * .pi / 180 }

}

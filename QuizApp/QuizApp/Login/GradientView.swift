import UIKit

class GradientView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        styleViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        styleViews()
    }

    override class var layerClass: AnyClass {
        CAGradientLayer.self
    }

}

extension GradientView: ConstructViewsProtocol {
    func createViews() {}

    func styleViews() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]

        guard let theLayer = layer as? CAGradientLayer else {
            return
        }

        theLayer.colors = [
            CGColor(red: 116 / 255, green: 79 / 255, blue: 163 / 255, alpha: 1.0),
            CGColor(red: 39 / 255, green: 47 / 255, blue: 118 / 255, alpha: 1.0)]
        theLayer.locations = [0.0, 1.0]
        theLayer.frame = bounds
    }

    func defineLayoutForViews() {}

}

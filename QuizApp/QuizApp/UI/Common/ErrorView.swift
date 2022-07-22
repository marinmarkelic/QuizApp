import UIKit

class ErrorView: UIView {

    private var imageView: UIImageView!
    private var title: UILabel!
    private var desc: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(description: String) {
        desc.text = description
    }

}

extension ErrorView: ConstructViewsProtocol {

    func createViews() {
        imageView = UIImageView()
        addSubview(imageView)

        title = UILabel()
        addSubview(title)

        desc = UILabel()
        addSubview(desc)
    }

    func styleViews() {
        let image = UIImage(systemName: "multiply.circle")
        imageView.image = image
        imageView.tintColor = .white

        title.text = "Error"
        title.font = UIFont(name: "SourceSansPro-Bold", size: 28)
        title.textColor = .white
        title.textAlignment = .center

        desc.font = UIFont(name: "SourceSansPro-Regular", size: 16)
        desc.textColor = .white
        desc.numberOfLines = 0
        desc.textAlignment = .center
    }

    func defineLayoutForViews() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(65)
        }

        title.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }

        desc.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }

}

import UIKit

class DetailsView: UIView {

    private var title: UILabel!
    private var desc: UILabel!
    private var imageView: UIImageView!
    private var startButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(quiz: Quiz) {
        title.text = quiz.name
        desc.text = quiz.description
        imageView.sd_setImage(with: URL(string: quiz.imageUrl))
    }

}

extension DetailsView: ConstructViewsProtocol {

    func createViews() {
        title = UILabel()
        addSubview(title)

        desc = UILabel()
        addSubview(desc)

        imageView = UIImageView()
        addSubview(imageView)

        startButton = UIButton()
        addSubview(startButton)
    }

    func styleViews() {
        backgroundColor = .white.withAlphaComponent(0.3)
        layer.cornerRadius = 10
        clipsToBounds = true

        title.font = UIFont(name: "SourceSansPro-Bold", size: 32)
        title.textAlignment = .center
        title.textColor = .white

        desc.font = UIFont(name: "SourceSansPro-Bold", size: 20)
        desc.textAlignment = .center
        desc.numberOfLines = 0
        desc.textColor = .white

        imageView.contentMode = .scaleAspectFit

        startButton.setTitle("Start Quiz", for: .normal)
    }

    func defineLayoutForViews() {
        title.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(20)
        }

        desc.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        imageView.snp.makeConstraints {
            $0.top.equalTo(desc.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(150)
        }

        startButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }

}

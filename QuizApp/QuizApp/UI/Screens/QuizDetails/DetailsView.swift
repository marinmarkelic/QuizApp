import UIKit

class DetailsView: UIView {

    weak var delegate: DetailsViewDelegate?

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

    func remakeLayout() {
        if UIDevice.current.orientation.isLandscape {
            title.snp.remakeConstraints {
                $0.height.equalTo(50)
                $0.top.equalToSuperview().inset(10)
                $0.leading.equalToSuperview().inset(20)
                $0.trailing.equalTo(snp.centerX).offset(-10)
            }

            desc.snp.remakeConstraints {
                $0.top.equalTo(title.snp.bottom).offset(5)
                $0.leading.trailing.equalTo(title)
            }

            imageView.snp.remakeConstraints {
                $0.top.equalTo(title)
                $0.leading.equalTo(snp.centerX).offset(10)
                $0.trailing.equalToSuperview().inset(20)
                $0.height.lessThanOrEqualTo(150)
            }

            startButton.snp.remakeConstraints {
                $0.top.equalTo(imageView.snp.bottom).offset(5)
                $0.leading.trailing.bottom.equalToSuperview().inset(20)
                $0.height.equalTo(45)
            }
        } else {
            title.snp.remakeConstraints {
                $0.leading.top.trailing.equalToSuperview().inset(20)
            }

            desc.snp.remakeConstraints {
                $0.top.equalTo(title.snp.bottom).offset(20)
                $0.leading.trailing.equalToSuperview().inset(20)
            }

            imageView.snp.remakeConstraints {
                $0.top.equalTo(desc.snp.bottom).offset(20)
                $0.centerX.equalToSuperview()
                $0.width.height.lessThanOrEqualTo(150)
            }

            startButton.snp.remakeConstraints {
                $0.top.equalTo(imageView.snp.bottom).offset(20)
                $0.leading.trailing.bottom.equalToSuperview().inset(20)
                $0.height.equalTo(45)
            }
        }
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
        startButton.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 16)
        startButton.backgroundColor = .white
        startButton.setTitleColor(UIColor(red: 99 / 255, green: 41 / 255, blue: 222 / 255, alpha: 1.0), for: .normal)
        startButton.layer.cornerRadius = 20
        startButton.clipsToBounds = true
        startButton.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
    }

    @objc
    private func buttonPress() {
        delegate?.startQuiz()
    }

    func defineLayoutForViews() {
        remakeLayout()
    }

}

protocol DetailsViewDelegate: AnyObject {

    func startQuiz()

}

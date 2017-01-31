import UIKit

class EmptyStateView: UIView {
    private let image: UIImage
    private let message: String

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        return imageView
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        return label
    }()

    private let contentView = UIView()

    init(image: UIImage = UIImage(named: "github")!, message: String) {
        self.image = image
        self.message = message
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        setupImageView()
        setupMessageLabel()
        setupContentView()
        setNeedsUpdateConstraints()
    }
    
    private func setupImageView() {
        imageView.image = image
        contentView.addSubview(imageView)
    }

    private func setupMessageLabel() {
        messageLabel.text = message
        contentView.addSubview(messageLabel)
    }
    
    private func setupContentView() {
        addSubview(contentView)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        constrainImageView()
        constrainMessageLabel()
        constrainContentView()
    }
    
    private func constrainImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                                      imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                      imageView.widthAnchor.constraint(equalToConstant: 80),
                                      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor) ])
    }

    private func constrainMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                      messageLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                                      messageLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                                      messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15) ])
    }

    private func constrainContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                      contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
                                      contentView.widthAnchor.constraint(equalToConstant: 160) ])
    }
}

import UIKit

class LoadingIndicatorView: UIView {
    private let message: String

    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicatorView.color = .darkGray
        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        label.textColor = .darkGray
        return label
    }()

    private let contentView = UIView()
    
    init(message: String) {
        self.message = message
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupActivityIndicatorView()
        setupMessageLabel()
        setupContentView()
        setNeedsUpdateConstraints()
    }
    
    private func setupActivityIndicatorView() {
        contentView.addSubview(activityIndicatorView)
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
        constrainActivityIndicatorView()
        constrainMessageLabel()
        constrainContentView()
    }
    
    private func constrainActivityIndicatorView() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ activityIndicatorView.topAnchor.constraint(equalTo: contentView.topAnchor),
                                      activityIndicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor) ])
    }
    
    private func constrainMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                      messageLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                                      messageLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor) ])
    }

    private func constrainContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                      contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
                                      contentView.heightAnchor.constraint(equalToConstant: 65) ])
    }
}

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .darkText
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()

    private let stargazersCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .right
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(stargazersCountLabel)
        setNeedsUpdateConstraints()
    }

    override func updateConstraints() {
        super.updateConstraints()
        constrainNameLabel()
        constrainDescriptionLabel()
        constrainStargazersCountLabel()
    }

    private func constrainNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
                                      nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12) ])
    }

    private func constrainDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
                                      descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
                                      descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
                                      descriptionLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor) ])
    }

    private func constrainStargazersCountLabel() {
        stargazersCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ stargazersCountLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
                                      stargazersCountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                      stargazersCountLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 12),
                                      stargazersCountLabel.widthAnchor.constraint(equalToConstant: 80) ])
    }

    func render(repository: Repository) {
        let details = RepositoryDetails(repository: repository)
        nameLabel.text = details.name
        descriptionLabel.text = details.description
        stargazersCountLabel.text = details.stargazerCount
    }
}

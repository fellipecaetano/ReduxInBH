import UIKit

class RepositoriesView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.reuseIdentifier)
        return tableView
    }()

    let refreshControl = UIRefreshControl()

    init() {
        super.init(frame: UIScreen.main.bounds)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        setupTableView()
        setNeedsUpdateConstraints()
    }

    private func setupTableView() {
        tableView.addSubview(refreshControl)
        addSubview(tableView)
    }

    override func updateConstraints() {
        super.updateConstraints()
        constrainTableView()
    }

    private func constrainTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ tableView.leftAnchor.constraint(equalTo: leftAnchor),
                                      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                      tableView.rightAnchor.constraint(equalTo: rightAnchor),
                                      tableView.topAnchor.constraint(equalTo: topAnchor) ])
    }
}

import UIKit

class RepositoriesViewController: UIViewController, UITableViewDataSource {
    private var repositories = [Repository]()
    private let service: RepositoryService

    init (service: RepositoryService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
        title = "Repositories"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = RepositoriesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        service.fetch { repositories, _ in
            self.repositories = repositories
            self.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = RepositoryTableViewCell.reuseIdentifier

        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? RepositoryTableViewCell else {
            fatalError("Could not dequeue reusable RepositoryTableViewCell with identifier \(reuseIdentifier)")
        }

        cell.render(repository: repositories[indexPath.row])
        return cell
    }
}

fileprivate extension RepositoriesViewController {
    var tableView: UITableView {
        return smartView.tableView
    }

    var smartView: RepositoriesView {
        return view as! RepositoriesView
    }
}

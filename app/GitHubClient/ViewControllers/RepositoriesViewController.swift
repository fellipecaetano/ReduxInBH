import UIKit
import Redux

class RepositoriesViewController: UIViewController, UITableViewDataSource {
    private var repositories = [Repository]()
    private let service: RepositoryService
    private unowned let store: Store<AppState>
    private var unsubscribe: (() -> Void)?

    init (service: RepositoryService, store: Store<AppState>) {
        self.service = service
        self.store = store
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
        refreshControl.addTarget(self, action: #selector(onRefresh(refreshControl:)), for: .valueChanged)
        store.dispatch(LoadRepositoriesCommand(service: service))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        unsubscribe = store.subscribe(render)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribe?()
    }

    private func render(state: AppState) {
        switch state.repositories {
        case .loading:
            tableView.backgroundView = LoadingIndicatorView(message: "Carregando repositórios")
            refreshControl.endRefreshing()

        case .loaded(let repositories) where repositories.isEmpty:
            tableView.backgroundView = EmptyStateView(message: "Nenhum repositório foi carregado")
            self.repositories = []
            tableView.reloadData()
            refreshControl.endRefreshing()

        case .loaded(let repositories):
            tableView.backgroundView = nil
            self.repositories = repositories
            tableView.reloadData()
            refreshControl.endRefreshing()

        case .refreshing, .none:
            break

        case .error:
            tableView.backgroundView = EmptyStateView(message: "Ocorreu um erro ao carregar os repositórios")
            repositories = []
            tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }

    @objc private func onRefresh(refreshControl: UIRefreshControl) {
        store.dispatch(RefreshRepositoriesCommand(service: service))
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

    var refreshControl: UIRefreshControl {
        return smartView.refreshControl
    }

    var smartView: RepositoriesView {
        return view as! RepositoriesView
    }
}

struct RepositoryDetails {
    private let repository: Repository

    init (repository: Repository) {
        self.repository = repository
    }

    var name: String {
        return repository.name
    }

    var description: String {
        return repository.description
    }

    var stargazerCount: String {
        let qualifier = repository.stargazersCount == 1 ? "star" : "stars"
        return "\(repository.stargazersCount) \(qualifier)"
    }
}

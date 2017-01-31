import Redux

enum RepositoriesState {
    case none
    case loading
    case loaded([Repository])
    case refreshing(previous: [Repository])
    case error(Error)
}

enum RepositoriesAction: Action {
    case loading
    case load([Repository])
    case refreshing
    case refresh([Repository])
    case fail(Error)
}

func RepositoriesReducer(state: RepositoriesState, action: Action) -> RepositoriesState {
    switch (state, action) {
    case (_, RepositoriesAction.loading):
        return .loading
        
    case (_, RepositoriesAction.load(let repositories)):
        return .loaded(repositories)
        
    case (.loaded(let repositories), RepositoriesAction.refreshing):
        return .refreshing(previous: repositories)
        
    case (_, RepositoriesAction.refreshing):
        return .refreshing(previous: [])
        
    case (_, RepositoriesAction.refresh(let repositories)):
        return .loaded(repositories)
        
    case (.refreshing(let repositories), RepositoriesAction.fail) where !repositories.isEmpty:
        return .loaded(repositories)
        
    case (_, RepositoriesAction.fail(let error)):
        return .error(error)
        
    default:
        return state
    }
}

class LoadRepositoriesCommand: Command {
    private let service: RepositoryService
    
    init (service: RepositoryService) {
        self.service = service
    }
    
    func run(state: () -> AppState, dispatch: @escaping (Action) -> Void) {
        dispatch(RepositoriesAction.loading)
        
        service.fetch { repositories, error in
            if let error = error {
                dispatch(RepositoriesAction.fail(error))
            } else {
                dispatch(RepositoriesAction.load(repositories))
            }
        }
    }
}

class RefreshRepositoriesCommand: Command {
    private let service: RepositoryService
    
    init (service: RepositoryService) {
        self.service = service
    }
    
    func run(state: () -> AppState, dispatch: @escaping (Action) -> Void) {
        dispatch(RepositoriesAction.refreshing)
        
        service.fetch { repositories, error in
            if let error = error {
                dispatch(RepositoriesAction.fail(error))
            } else {
                dispatch(RepositoriesAction.refresh(repositories))
            }
        }
    }
}

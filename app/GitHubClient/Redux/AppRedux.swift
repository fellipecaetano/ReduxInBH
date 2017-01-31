import Redux

struct AppState {
    let repositories: RepositoriesState

    static var initial: AppState {
        return AppState(repositories: .none)
    }
}

func AppReducer(state: AppState, action: Action) -> AppState {
    return AppState(
        repositories: RepositoriesReducer(state: state.repositories, action: action)
    )
}

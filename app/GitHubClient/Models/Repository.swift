import Foundation

struct Repository {
    let name: String
    let description: String
    let stargazersCount: Int

    init? (attributes: [String: Any]) {
        guard let name = attributes["name"] as? String,
            let description = attributes["description"] as? String,
            let stargazersCount = attributes["stargazers_count"] as? Int else {
                return nil
        }

        self.name = name
        self.description = description
        self.stargazersCount = stargazersCount
    }
}

class RepositoryService {
    private let session: URLSession
    private let username: String

    init (username: String) {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest = 5
        self.session = URLSession(configuration: configuration)
        self.username = username
    }

    func fetch(completion: @escaping ([Repository], Error?) -> Void) {
        let completeOnMainThread: ([Repository], Error?) -> Void = { repositories, error in
            DispatchQueue.main.async { completion(repositories, error) }
        }

        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completeOnMainThread([], error)
                return
            }

            if let response = response as? HTTPURLResponse, response.statusCode < 200 || response.statusCode > 299 {
                completeOnMainThread([], RepositoryServiceError.unacceptableStatusCode(response.statusCode))
                return
            }

            guard let data = data else {
                completeOnMainThread([], RepositoryServiceError.noData)
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])

                guard let attributes = json as? [[String: Any]] else {
                    completeOnMainThread([], RepositoryServiceError.invalidResponse)
                    return
                }

                let repositories = attributes.flatMap(Repository.init)
                completeOnMainThread(repositories, nil)
            } catch let error {
                completeOnMainThread([], error)
            }
        }

        task.resume()
    }

    private var url: URL {
        return URL(string: "https://api.github.com/users/\(username)/repos?sort=updated")!
    }
}

enum RepositoryServiceError: Error {
    case noData
    case invalidResponse
    case unacceptableStatusCode(Int)

    var localizedDescription: String {
        switch self {
        case .noData:
            return "There was no data available for parsing in the response."
        case .invalidResponse:
            return "The response was in an unexpected format."
        case .unacceptableStatusCode(let statusCode):
            return "The response's status code was \(statusCode)."
        }
    }
}

import UIKit
import Redux

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let store = Store<AppState>(initialState: AppState(), reducer: AppReducer)

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white

        self.window?.rootViewController = UINavigationController(
            rootViewController: RepositoriesViewController(
                service: RepositoryService(username: "fellipecaetano")
            )
        )

        self.window?.makeKeyAndVisible()
        return true
    }
}

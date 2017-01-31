import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.rootViewController = UIViewController()
        self.window?.makeKeyAndVisible()

        let service = RepositoryService(username: "fellipecaetano")

        service.fetch { repositories, error in
            print(repositories)
            print(error?.localizedDescription ?? "")
        }

        return true
    }
}

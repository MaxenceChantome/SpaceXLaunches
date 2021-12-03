//
//  AppDelegate.swift
//  SpaceXLaunches
//
//  Created by Maxence Chantôme on 01/12/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var rootController: UINavigationController { return self.window!.rootViewController as! UINavigationController }
    private lazy var applicationCoordinator: Coordinator = self.makeCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        window?.makeKeyAndVisible()
        window?.rootViewController = AppNavigationController()
        applicationCoordinator.start(with: nil)

        return true
    }

    private func makeCoordinator() -> Coordinator {
        return AppCoordinator(router: Router(rootController: rootController), apiService: ApiService())
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
   
            var parameters: [String: String] = [:]
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = $0.value
            }
        
            if let id = parameters["id"] {
                applicationCoordinator.start(with: DeepLink.rocket(id: id))
            }
        return true
    }
}

//
//  AppDelegate.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 22/1/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootCoordinator: PostListCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initialLoading()
        return true
    }

    // MARK: - Initial loader
    
    private func initialLoading() {
        PostLibrary.shared.clear()
        rootCoordinator = PostListCoordinator(navigationController: UINavigationController())
        rootCoordinator.navigate(animated: false)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootCoordinator.navigationController
        window?.makeKeyAndVisible()
    }
}


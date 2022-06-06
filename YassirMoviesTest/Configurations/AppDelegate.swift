//
//  AppDelegate.swift
//  YassirMovies
//
//  Created by Rihab Dhemaied on 06/06/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        displayFirstInterface()
        return true
    }
    
    private func displayFirstInterface() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        let firstViewController = HomeViewController()
        navController.pushViewController(firstViewController, animated: false)
        navController.navigationBar.isHidden = true
        self.window?.rootViewController = navController
        window?.makeKeyAndVisible()

    }
}

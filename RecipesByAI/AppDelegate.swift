//
//  AppDelegate.swift
//  RecipesByAI
//
//  Created by Glauber Gustavo on 11/04/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: HomeRouter().viewController)
        window?.makeKeyAndVisible()
        
        return true
    }
}


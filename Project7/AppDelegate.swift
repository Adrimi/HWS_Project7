//
//  AppDelegate.swift
//  Project7
//
//  Created by Adrimi on 01/07/2019.
//  Copyright © 2019 Adrimi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Window of the actuall application
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Default root should be the TabBarController, sure better to check it
        if let tabBarController = window?.rootViewController as? UITabBarController {
            
            // Find in the Bundle the "Main" storyboard and assign to let
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            // Instantiate
            let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
            
            // Attach TabBar, with unique tag
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
            
            // Show the navigation controller
            tabBarController.viewControllers?.append(vc)
        }
        
        return true
    }
}


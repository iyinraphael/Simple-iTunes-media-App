//
//  AppDelegate.swift
//  Simple-iTunes-media-App
//
//  Created by Iyin Raphael on 6/2/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ParentTabBarController())
        window?.makeKeyAndVisible()
        
        return true
    }
}


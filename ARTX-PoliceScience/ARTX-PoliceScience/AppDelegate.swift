//
//  AppDelegate.swift
//  ARTX-uikit-study
//
//  Created by 신상용 on 2023/09/15.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor(hexCode: "F2F2F7")
//        window?.rootViewController = HomeViewController()
        window?.rootViewController = BookViewController()
        FirebaseApp.configure()
        return true
    }
}


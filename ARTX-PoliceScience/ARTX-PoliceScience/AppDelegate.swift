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
        window?.backgroundColor = .bgPrimary
//        globalQuestion = LoadQuestionModel.loadQuestionModel()
        let navigationController = UINavigationController(rootViewController: HomeViewController())
        window?.rootViewController = navigationController
        FirebaseApp.configure()
        
        //처음 설치시 UserDefaults 초기화
        if !LocalState.firstInstall {
            PartChapter.resetPartChapter()
            LocalState.firstInstall = true
        }
        
        totalQuestionCountModel.totalQuestionCount()
        
        return true
    }
}


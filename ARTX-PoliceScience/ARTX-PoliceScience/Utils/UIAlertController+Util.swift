//
//  UIAlertController+Util.swift
//  ARTX-PoliceScience
//
//  Created by Jae Ho Yoon on 10/16/23.
//

import UIKit

//extension UIAlertController {
//    func show() {
//        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//        let window = scene?.windows.first
//        let rootViewController = window?.rootViewController
//        rootViewController?.present(self, animated: true, completion: nil)
//    }
//}

extension UIAlertController {
    
    func show() {
        present(animated: true, completion: nil)
    }
    
    func present(animated: Bool, completion: (() -> Void)?) {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            presentFromController(controller: rootVC, animated: animated, completion: completion)
        }
    }
    
    private func presentFromController(controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if
            let navVC = controller as? UINavigationController,
            let visibleVC = navVC.visibleViewController
        {
            presentFromController(controller: visibleVC, animated: animated, completion: completion)
        } else if
            let tabVC = controller as? UITabBarController,
            let selectedVC = tabVC.selectedViewController
        {
            presentFromController(controller: selectedVC, animated: animated, completion: completion)
        } else if let presented = controller.presentedViewController {
            presentFromController(controller: presented, animated: animated, completion: completion)
        } else {
            controller.present(self, animated: animated, completion: completion);
        }
    }
}

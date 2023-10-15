//
//  UIAlertController+Util.swift
//  ARTX-PoliceScience
//
//  Created by Jae Ho Yoon on 10/16/23.
//

import UIKit

extension UIAlertController {
    func show() {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = scene?.windows.first
        let rootViewController = window?.rootViewController
        rootViewController?.present(self, animated: true, completion: nil)
    }
}

//
//  UINavigationController+Util.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/6/23.
//

import UIKit

extension UINavigationController {
    func configureNavigationBar(withTitle title: String) {
        topViewController?.title = title
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBlue
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }

    func addBackButton(target: UIViewController, action: Selector) {
        let backArrowImage = UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        let backButton = UIBarButtonItem(image: backArrowImage, style: .plain, target: target, action: action)
        backButton.tintColor = .white
        topViewController?.navigationItem.leftBarButtonItem = backButton
        
    }
}

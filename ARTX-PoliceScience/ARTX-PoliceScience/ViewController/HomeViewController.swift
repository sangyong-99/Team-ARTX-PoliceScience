//
//  HomeViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    let settingViewController = SettingViewController()
    
    let stackView = UIStackView()
    let settingViewButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension HomeViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        settingViewButton.translatesAutoresizingMaskIntoConstraints = false
        settingViewButton.setTitle("Setting View 바로가기", for: [])
        settingViewButton.addTarget(self, action: #selector(settingViewButtonTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        stackView.addArrangedSubview(settingViewButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension HomeViewController {
    @objc func settingViewButtonTapped(sender: UIButton) {
        navigationController?.pushViewController(settingViewController, animated: true)
    }
}

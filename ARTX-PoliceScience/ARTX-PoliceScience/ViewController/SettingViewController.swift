//
//  SettingViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class SettingViewController: UIViewController {
    
    let stackView = UIStackView()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension SettingViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        //네비게이션 세팅
        navigationBarSetting()
        view.backgroundColor = .bgGroupedPrimary
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Setting view"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    func layout() {
        stackView.addArrangedSubview(label)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    @objc func backButtonTapped() {
        // Handle the back button tap here
        navigationController?.popViewController(animated: true)
    }
}

//네비게이션 관련 extension
extension SettingViewController {
    private func navigationBarSetting() {
        title = "환경 설정"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .bgBlue
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.graysWhite]
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.graysWhite]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
        let backArrowImage = UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        let backButton = UIBarButtonItem(image: backArrowImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .graysWhite
        self.navigationItem.leftBarButtonItem = backButton
    }
}


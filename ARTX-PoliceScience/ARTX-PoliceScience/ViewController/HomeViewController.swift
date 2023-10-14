//
//  HomeViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    let settingViewController = SettingViewController()
    let bookViewController = BookViewController()
    
    let stackView = UIStackView()
    // settingViewButton Navigation Button
    let settingViewButton = UIButton(type: .system)
    //UserDefault 확인용 label
    let isCodeActivatedLabel = UILabel()
    let authenticationCodeLabel = UILabel()
    
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
        
        //settingview들어가는 navigation button
        settingViewButton.translatesAutoresizingMaskIntoConstraints = false
        settingViewButton.setTitle("Setting View 바로가기", for: [])
        settingViewButton.addTarget(self, action: #selector(settingViewButtonTapped), for: .primaryActionTriggered)
        
        //userdefaults 보여주는 label style 설정
        isCodeActivatedLabel.text = " 현재 LocalState.isCodeActivated = \(String(LocalState.isCodeActivated))"
        isCodeActivatedLabel.textColor = .white
        
        authenticationCodeLabel.text = "현재 LocalState.authenticationCode = \(LocalState.authenticationCode ?? "미등록")"
        authenticationCodeLabel.textColor = .white
    }
    
    func layout() {
        stackView.addArrangedSubview(settingViewButton)
        stackView.addArrangedSubview(isCodeActivatedLabel)
        stackView.addArrangedSubview(authenticationCodeLabel)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - UserDefault isCodeActivated가 업데이트 될때 리랜더링 하는 코드
extension HomeViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isCodeActivatedLabel.text = " 현재 LocalState.isCodeActivated = \(String(LocalState.isCodeActivated))"
        authenticationCodeLabel.text = "현재 LocalState.authenticationCode = \(LocalState.authenticationCode ?? "미등록")"
        
        // isCodeActivated 값을 기반으로 뷰 업데이트
//        if isCodeActivated {
//            isCodeActivatedLabel.text = " 현재 LocalState.isCodeActivated = \(String(LocalState.isCodeActivated))"
//        } else {
//            isCodeActivatedLabel.text = " 현재 LocalState.isCodeActivated = \(String(LocalState.isCodeActivated))"
//        }
    }
}


// MARK: - SettingViewButton 클릭했을때 pushView해주는 함수
extension HomeViewController {
    @objc func settingViewButtonTapped(sender: UIButton) {
        navigationController?.pushViewController(settingViewController, animated: true)
    }
}

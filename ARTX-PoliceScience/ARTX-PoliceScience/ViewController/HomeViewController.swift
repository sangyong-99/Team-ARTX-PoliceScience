//
//  HomeViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let homeTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        table.register(HomeTableViewSectionHeader.self, forHeaderFooterViewReuseIdentifier: HomeTableViewSectionHeader.identifier)
        table.rowHeight = HomeTableViewCell.rowHeight
        return table
    }()
    
    let settingViewController = SettingViewController()
    
    let testStackView = UIStackView()
    // settingViewButton Navigation Button
    let settingViewButton = UIButton(type: .system)
    //UserDefault 확인용 label
    let isCodeActivatedLabel = UILabel()
    let authenticationCodeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeViewModel.configure()
        style()
        layout()
//        testUI() // Code활성화 테스트 & 설정화면 작업 코드
    }
}

extension HomeViewController {
    func style() {
        
        view.backgroundColor = .bgGroupedPrimary
        
        //tableview 설정
        view.addSubview(homeTableView)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.frame = view.bounds
        
    }
    
    func layout() {
        
        
    }
}

extension HomeViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeViewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeTableViewSectionHeader.identifier) as! HomeTableViewSectionHeader
        
        header.configure(with: HomeViewModel.sections[section])
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeViewModel.sections[section].chapters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = HomeViewModel.sections[indexPath.section].chapters[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: model)
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // 진행 상황 체크 후 Alert
        // 문제 푸는 곳으로 넘어가기
    }
}


// MARK: - Code활성화 테스트 & 설정화면 작업 코드
extension HomeViewController {
    func testUI() {
        // style
        testStackView.translatesAutoresizingMaskIntoConstraints = false
        testStackView.axis = .vertical
        testStackView.spacing = 20
        
        //settingview들어가는 navigation button
        settingViewButton.translatesAutoresizingMaskIntoConstraints = false
        settingViewButton.setTitle("Setting View 바로가기", for: [])
        settingViewButton.addTarget(self, action: #selector(settingViewButtonTapped), for: .primaryActionTriggered)
        
        //userdefaults 보여주는 label style 설정
        isCodeActivatedLabel.text = " 현재 LocalState.isCodeActivated = \(String(LocalState.isCodeActivated))"
        isCodeActivatedLabel.textColor = .white
        
        authenticationCodeLabel.text = "현재 LocalState.authenticationCode = \(LocalState.authenticationCode ?? "미등록")"
        authenticationCodeLabel.textColor = .white
        
        // layout
        testStackView.addArrangedSubview(settingViewButton)
        testStackView.addArrangedSubview(isCodeActivatedLabel)
        testStackView.addArrangedSubview(authenticationCodeLabel)
        
        view.addSubview(testStackView)
        
        NSLayoutConstraint.activate([
            testStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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

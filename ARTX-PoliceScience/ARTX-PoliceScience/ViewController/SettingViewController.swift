//
//  SettingViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let settingTableView: UITableView = {
        let table = UITableView(frame:.zero, style: .insetGrouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(RegisSettingTableViewCell.self, forCellReuseIdentifier: RegisSettingTableViewCell.identifier)
        return table
    }()
    
    private let settingLabel: UILabel = {
        let label = UILabel()
        label.text = "버전 정보\nVer 1.0001\nDeveloped by Team ARTX"
        label.numberOfLines = 0 // 여러 줄을 허용합니다.
        label.textColor = UIColor.secondaryLabel
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    //    let label = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.configureNavigationBar(withTitle: "환경 설정")
        navigationController?.addBackButton(target: self, action: #selector(backButtonTapped))
        
        SettingViewModel.configure()
        
        style()
        layout()
    }
}

extension SettingViewController {
    func style() {
        
        //네비게이션바 세팅
        view.backgroundColor = .bgGroupedPrimary
        
        //tableview 설정
        settingTableView.isScrollEnabled = false
        view.addSubview(settingTableView)
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.frame = view.bounds
        
        
        
        view.addSubview(settingLabel)
    }
    
    func layout() {
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingLabel.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -65),
        ])
    }
}

extension SettingViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingViewModel.models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingViewModel.models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = SettingViewModel.models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingTableViewCell.identifier,
                for: indexPath
            ) as? SettingTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            
            return cell
            
        case .regisCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RegisSettingTableViewCell.identifier,
                for: indexPath
            ) as? RegisSettingTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = SettingViewModel.models[indexPath.section].options[indexPath.row]
        
        switch type.self {
        case .staticCell(let model):
            model.handler(tableView, indexPath)
            
        case .regisCell(let model):
            model.handler(tableView, indexPath)
        }
    }
    
}


//네비게이션 관련 extension
extension SettingViewController {
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}


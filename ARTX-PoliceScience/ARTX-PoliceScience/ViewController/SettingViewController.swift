//
//  SettingViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView(frame:.zero, style: .insetGrouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        return table
    }()
    
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
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    func layout() {
        
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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingTableViewCell.identifier,
            for: indexPath
        ) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = SettingViewModel.models[indexPath.section].options[indexPath.row]
        model.handler()
    }
    
}


//네비게이션 관련 extension
extension SettingViewController {
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}


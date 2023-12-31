//
//  SettingViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var safeAreaLength: Double = 0.0
    
    private let settingTableView: UITableView = {
        let table = UITableView(frame:.zero, style: .insetGrouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(RegisSettingTableViewCell.self, forCellReuseIdentifier: RegisSettingTableViewCell.identifier)
        return table
    }()
    
    private let settingLabel: UILabel = {
        let label = UILabel()
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        label.text = "버전 정보 Ver \(appVersion ?? "1.0")\nDeveloped by Team ARTX"
        label.numberOfLines = 0 // 여러 줄을 허용합니다.
        label.textColor = UIColor.secondaryLabel
        label.textAlignment = .center
        label.font = .footNote
        return label
    }()
    
    private let navBackView: UIView = {
        let settingNavBackView = UIView()
        settingNavBackView.backgroundColor = .bgBlue
        
        return settingNavBackView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.configureNavigationBar(withTitle: "환경 설정")
        navigationController?.addBackButton(target: self, action: #selector(backButtonTapped))
        navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let window = UIApplication.shared.windows.first {
            safeAreaLength = Double((window.windowScene?.statusBarManager?.statusBarFrame.height)!)
        }
        
        SettingViewModel.configure()
        
        style()
        layout()
    }
}

extension SettingViewController {
    func style() {
        
        //tableview 설정
        settingTableView.isScrollEnabled = false
        view.addSubview(settingTableView)
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.frame = view.bounds
        
        view.addSubview(navBackView)
        view.addSubview(settingLabel)
        
    }
    
    func layout() {
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingLabel.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -65),
        ])
        
        navBackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBackView.topAnchor.constraint(equalTo: view.topAnchor),
            navBackView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            navBackView.heightAnchor.constraint(equalToConstant: navigationController!.navigationBar.frame.size.height + Double(safeAreaLength))
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
        navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.post(name: Notification.Name("changeQuizToHomeview"), object: nil)
    }
}


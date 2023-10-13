//
//  HomeViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var safeAreaLength = 0
    var isScrollEnabled = true
    
    let settingViewController = SettingViewController()
    private let homeTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(MainViewCell.self, forCellReuseIdentifier: MainViewCell.identifier)
        return table
    }()
    
    var header: UIView = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isScrollEnabled = true
        navigationController?.isNavigationBarHidden = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        header = tableHeaderView()
        
        homeTableView.tableHeaderView = header
        view.addSubview(homeTableView)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.frame = view.bounds
        homeTableView.contentInsetAdjustmentBehavior = .never
        
        title = "조현 경찰학"
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .regular)
        let symbolImage = UIImage(systemName: "book.fill", withConfiguration: symbolConfiguration)
        
        let rightBarButtonItem = UIBarButtonItem(
            image: symbolImage,
            style: .plain,
            target: self,
            action: #selector(rightItemTapped)
        )
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isScrollEnabled {
            let offsetY = scrollView.contentOffset.y
            
            if offsetY > CGFloat(safeAreaLength + 210) {
                navigationController?.setNavigationBarHidden(false, animated: true)
            } else {
                navigationController?.setNavigationBarHidden(true, animated: true)
            }
        }
    }
}

extension HomeViewController {
    
    func tableHeaderView() -> UIView {
        
        if let window = UIApplication.shared.windows.first {
            safeAreaLength = Int(window.safeAreaInsets.top)
        }
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: Int(CGFloat(view.frame.size.width)), height: safeAreaLength+314))
        
        let headerLabel = UILabel(frame: header.bounds)
        
        headerLabel.text = "Home"
        headerLabel.textAlignment = .center
        header.addSubview(headerLabel)
        
        let headerBackImage: UIImageView = {
            let headerBackImage = UIImageView()
            headerBackImage.image = UIImage(named: "MainViewTopImage")
            headerBackImage.contentMode = .scaleAspectFill
            return headerBackImage
        }()
        headerBackImage.translatesAutoresizingMaskIntoConstraints = false
        
        header.addSubview(headerBackImage)
        
        
        NSLayoutConstraint.activate([
            headerBackImage.leadingAnchor.constraint(equalTo: header.leadingAnchor),
            headerBackImage.trailingAnchor.constraint(equalTo: header.trailingAnchor),
            headerBackImage.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -68)
        ])
        
        let settingViewButton: UIButton = {
            let settingButton = UIButton(type: .system)
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 28)
            settingButton.setImage(UIImage(systemName: "gearshape.fill", withConfiguration: symbolConfiguration), for: .normal)
            
            settingButton.addTarget(self, action: #selector(SettingButtonTapped), for: .touchUpInside)
            settingButton.tintColor = .white
            
            return settingButton
        }()
        
        
        settingViewButton.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(settingViewButton)
        
        NSLayoutConstraint.activate([
            settingViewButton.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -24),
            settingViewButton.topAnchor.constraint(equalTo: header.safeAreaLayoutGuide.topAnchor, constant: 4)
        ])
        
        let titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.text = "조현 경찰학"
            titleLabel.textColor = .white
            titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
            return titleLabel
        }()
        
        let subTitleLabel: UILabel = {
            let subTitleLabel = UILabel()
            subTitleLabel.text = "OX 문제집"
            subTitleLabel.textColor = .white
            subTitleLabel.font = UIFont.systemFont(ofSize: 34, weight: .medium)
            return subTitleLabel
        }()
        
        let titleStackView: UIStackView = {
            let titleStackView = UIStackView()
            titleStackView.axis = .vertical
            titleStackView.addArrangedSubview(titleLabel)
            titleStackView.addArrangedSubview(subTitleLabel)
            
            return titleStackView
        }()
        
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(titleStackView)
        
        NSLayoutConstraint.activate([
            titleStackView.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 24),
            titleStackView.topAnchor.constraint(equalTo: header.safeAreaLayoutGuide.topAnchor, constant: 32)
        ])
        
        let introduceButtonImageLabel: UILabel = {
            let introduceButtonImageLabel = UILabel()
            if let symbolImage = UIImage(systemName: "arrowtriangle.forward.circle.fill")?.withRenderingMode(.alwaysTemplate) {
                
                let symbolAttachment = NSTextAttachment()
                
                let scaledImage = symbolImage.withConfiguration(UIImage.SymbolConfiguration(pointSize: 12, weight: .medium))
                symbolAttachment.image = scaledImage
                
                let attributedString = NSMutableAttributedString(string: "")
                attributedString.append(NSAttributedString(string: "책 소개 "))
                attributedString.append(NSAttributedString(attachment: symbolAttachment))
                
                introduceButtonImageLabel.attributedText = attributedString
                
                introduceButtonImageLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
                introduceButtonImageLabel.textColor = .white
                
                introduceButtonImageLabel.isUserInteractionEnabled = true
                let introduceTapGesture = UITapGestureRecognizer(target: self, action: #selector(introduceButtonTapped))
                introduceButtonImageLabel.addGestureRecognizer(introduceTapGesture)
            }
            return introduceButtonImageLabel
            
        }()
        
        introduceButtonImageLabel.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(introduceButtonImageLabel)
        
        NSLayoutConstraint.activate([
            introduceButtonImageLabel.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -24),
            introduceButtonImageLabel.topAnchor.constraint(equalTo: header.safeAreaLayoutGuide.topAnchor, constant: 114)
        ])
        
        let studyProgressView: UIView = {
            let studyProgressView = UIView()
            studyProgressView.backgroundColor = .white
            studyProgressView.layer.cornerRadius = 14
            studyProgressView.layer.masksToBounds = true
            return studyProgressView
        }()
        
        studyProgressView.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(studyProgressView)
        
        NSLayoutConstraint.activate([
            studyProgressView.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -22),
            studyProgressView.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 24),
            studyProgressView.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -24),
            studyProgressView.heightAnchor.constraint(equalToConstant: 148)
        ])
        
        let progressTitleLabel: UILabel = {
            let progressTitleLabel = UILabel()
            if let symbolImage = UIImage(systemName: "chart.bar.fill")?.withRenderingMode(.alwaysTemplate) {
                
                let symbolAttachment = NSTextAttachment()
                
                let scaledImage = symbolImage.withConfiguration(UIImage.SymbolConfiguration(pointSize: 12, weight: .regular))
                symbolAttachment.image = scaledImage
                
                let attributedString = NSMutableAttributedString(string: "")
                attributedString.append(NSAttributedString(attachment: symbolAttachment))
                attributedString.append(NSAttributedString(string: " 전체 학습 진행도"))
                
                progressTitleLabel.attributedText = attributedString
                
                progressTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
                progressTitleLabel.textColor = .black
                
            }
            return progressTitleLabel
            
        }()
        
        progressTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        studyProgressView.addSubview(progressTitleLabel)
        
        NSLayoutConstraint.activate([
            progressTitleLabel.leadingAnchor.constraint(equalTo: studyProgressView.leadingAnchor, constant: 16),
            progressTitleLabel.topAnchor.constraint(equalTo: studyProgressView.topAnchor, constant: 16)
        ])
        return header
    }
}

// MARK: - HomeViewButtonTapped
extension HomeViewController {
    @objc func SettingButtonTapped() {
        isScrollEnabled = false
        navigationController?.pushViewController(settingViewController, animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc func introduceButtonTapped() {
        isScrollEnabled = false
        navigationController?.pushViewController(BookViewController(), animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc func rightItemTapped() {
        isScrollEnabled = false
        navigationController?.pushViewController(BookViewController(), animated: true)
        navigationController?.isNavigationBarHidden = false
    }
}

// MARK: - TableView Delegate, DataSource
extension HomeViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return globalQuestion.quiz.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalQuestion.quiz[section].chapters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quizChapterModel = globalQuestion.quiz[indexPath.section].chapters[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MainViewCell.identifier,
            for: indexPath
        ) as? MainViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: quizChapterModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.section), \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let quizPartModel = globalQuestion.quiz[section]
        let headerView = UIView()
        
        let partLabel: UILabel = {
            let label = UILabel()
            label.text = "PART \(quizPartModel.part)"
            label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
            label.textColor = .textBlue
            
            let attributedText = NSAttributedString(string: label.text ?? "", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
            label.attributedText = attributedText
            
            return label
        }()
        
        let partNameLabel: UILabel = {
            let label = UILabel()
            label.text = quizPartModel.part_name
            label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            return label
        }()
        
        let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .leading
            stackView.spacing = 8
            stackView.addArrangedSubview(partLabel)
            stackView.addArrangedSubview(partNameLabel)
            return stackView
        }()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -14)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // 섹션 헤더 뷰의 높이를 반환합니다.
        return 73 // 원하는 높이로 설정
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69.0
    }
}

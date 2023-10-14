//
//  HomeViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var observeProgress: NSKeyValueObservation?
    var observeProgressViewWidth: NSKeyValueObservation?
    
    @objc dynamic var progress: Float = (20/30)
    @objc dynamic var progressViewWidth: CGFloat = 0.0
    
    var safeAreaLength = 0
    var isScrollEnabled = true
    
    // MARK: - TableView
    let settingViewController = SettingViewController()
    private let homeTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(MainViewCell.self, forCellReuseIdentifier: MainViewCell.identifier)
        return table
    }()
    
    // MARK: - Header View
    let headerBackImage: UIImageView = {
        let headerBackImage = UIImageView()
        headerBackImage.image = UIImage(named: "MainViewTopImage")
        headerBackImage.contentMode = .scaleAspectFill
        return headerBackImage
    }()
    
    let settingViewButton: UIButton = {
        let settingButton = UIButton(type: .system)
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 22)
        settingButton.setImage(UIImage(systemName: "gearshape.fill", withConfiguration: symbolConfiguration), for: .normal)
        settingButton.tintColor = .white
        return settingButton
    }()
    
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
        return titleStackView
    }()
    
    let bookintroduceButton: UIButton = {
        let bookintroduceButton = UIButton()
        
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: "책 소개 ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .medium)]))
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold)
        let symbolImage = UIImage(systemName: "arrowtriangle.forward.circle.fill")?.withConfiguration(symbolConfiguration).withTintColor(.white)
        let textAttachment = NSTextAttachment()
        textAttachment.image = symbolImage
        let imageString = NSAttributedString(attachment: textAttachment)
        attributedText.append(imageString)
        
        bookintroduceButton.setTitleColor(.white, for: .normal)
        bookintroduceButton.setAttributedTitle(attributedText, for: .normal)
        
        return bookintroduceButton
    }()
    
    let studyProgressView: UIView = {
        let studyProgressView = UIView()
        studyProgressView.backgroundColor = .white
        studyProgressView.layer.cornerRadius = 14
        studyProgressView.layer.masksToBounds = true
        return studyProgressView
    }()
    
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
    
    let progressViewLabel: UILabel = {
        let progressViewLabel = UILabel()
        progressViewLabel.text = "%"
        progressViewLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        return progressViewLabel
    }()
    
    let progressValueLabel: UILabel = {
        let progressValueLabel = UILabel()
        
        progressValueLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        
        return progressValueLabel
    }()
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.trackTintColor = .pointGray
        progressView.progressTintColor = .barPoint
        
        progressView.layer.cornerRadius = 6
        progressView.clipsToBounds = true
        return progressView
    }()
    
    let headerBookmarkButton: UIButton = {
        let headerBookmarkButton = UIButton()
        headerBookmarkButton.layer.cornerRadius = 20
        headerBookmarkButton.clipsToBounds = true
        headerBookmarkButton.layer.borderWidth = 1
        headerBookmarkButton.layer.borderColor = UIColor.textBlue.cgColor
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold)
        headerBookmarkButton.setImage(UIImage(systemName: "book.fill")?.withConfiguration(symbolConfiguration), for: .normal)
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: " 오답 노트", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .heavy)]))
        headerBookmarkButton.setAttributedTitle(attributedText, for: .normal)
        
        headerBookmarkButton.setTitleColor(.textBlue, for: .normal)
        
        headerBookmarkButton.contentHorizontalAlignment = .center
        headerBookmarkButton.contentVerticalAlignment = .center
        
        return headerBookmarkButton
    }()
    
    let progressImages: UIImageView = {
        let progressImage = UIImageView()
        progressImage.image = UIImage(named: "HeaderImage1")
        progressImage.frame = CGRect(x: 0, y: 0, width: 22, height: 22) // 원하는 크기로 설정
        
        return progressImage
    }()
    // MARK: - ViewController
    var header: UIView = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isScrollEnabled = true
        navigationController?.isNavigationBarHidden = true
        
        navigationController?.homeViewconfigureNavigationBar()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let newLeadingConstant = progressView.frame.size.width * CGFloat(progress)
        let newLeadingConstraint = progressImages.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: newLeadingConstant)
        
        newLeadingConstraint.isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewNavBar()
        navigationController?.isNavigationBarHidden = true
        
        header = tableHeaderView()
        homeTableView.tableHeaderView = header
        
        view.addSubview(homeTableView)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.frame = view.bounds
        homeTableView.contentInsetAdjustmentBehavior = .never
        
        observeProgress = observe(\.progress, options: [.new]) { [weak self] (object, change) in
            if let newValue = change.newValue {
                self?.updateViewsForProgress(newValue)
                self!.view.layoutIfNeeded()
            }
        }
    }
    func updateViewsForProgress(_ newProgress: Float) {
        let progressValueText = "\(Int(newProgress * 100))"
        progressValueLabel.text = progressValueText
        progressView.progress = newProgress
    }
}

// MARK: - HomeViewHeader 그리는 코드
extension HomeViewController {
    func tableHeaderView() -> UIView {
        if let window = UIApplication.shared.windows.first {
            safeAreaLength = Int(window.safeAreaInsets.top)
        }
        let header = UIView(frame: CGRect(x: 0, y: 0, width: Int(CGFloat(view.frame.size.width)), height: safeAreaLength+314))
        
        // MARK: - headerBackImage
        
        headerBackImage.translatesAutoresizingMaskIntoConstraints = false
        
        header.addSubview(headerBackImage)
        
        NSLayoutConstraint.activate([
            headerBackImage.leadingAnchor.constraint(equalTo: header.leadingAnchor),
            headerBackImage.trailingAnchor.constraint(equalTo: header.trailingAnchor),
            headerBackImage.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -68)
        ])
        
        // MARK: - settingViewButton
        
        settingViewButton.addTarget(self, action: #selector(SettingButtonTapped), for: .touchUpInside)
        settingViewButton.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(settingViewButton)
        
        NSLayoutConstraint.activate([
            settingViewButton.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -24),
            settingViewButton.topAnchor.constraint(equalTo: header.safeAreaLayoutGuide.topAnchor, constant: 4)
        ])
        // MARK: - titleStackView 조현 경찰학 OX 문제집
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subTitleLabel)
        
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(titleStackView)
        
        NSLayoutConstraint.activate([
            titleStackView.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 24),
            titleStackView.topAnchor.constraint(equalTo: header.safeAreaLayoutGuide.topAnchor, constant: 32)
        ])
        // MARK: - bookintroduceButton 책 소개 버튼
        
        bookintroduceButton.addTarget(self, action: #selector(introduceButtonTapped), for: .touchUpInside)
        bookintroduceButton.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(bookintroduceButton)
        
        NSLayoutConstraint.activate([
            bookintroduceButton.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -24),
            bookintroduceButton.topAnchor.constraint(equalTo: header.safeAreaLayoutGuide.topAnchor, constant: 114)
        ])
        // MARK: - studyProgressView 하얀색 뷰 UIView
        
        studyProgressView.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(studyProgressView)
        
        NSLayoutConstraint.activate([
            studyProgressView.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -22),
            studyProgressView.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 24),
            studyProgressView.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -24),
            studyProgressView.heightAnchor.constraint(equalToConstant: 148)
        ])
        
        
        // MARK: - progressTitleLabel 전체 학습 진행도
        
        progressTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        studyProgressView.addSubview(progressTitleLabel)
        
        NSLayoutConstraint.activate([
            progressTitleLabel.leadingAnchor.constraint(equalTo: studyProgressView.leadingAnchor, constant: 16),
            progressTitleLabel.topAnchor.constraint(equalTo: studyProgressView.topAnchor, constant: 16)
        ])
        // MARK: - progressViewLabel %
        
        progressViewLabel.translatesAutoresizingMaskIntoConstraints = false
        studyProgressView.addSubview(progressViewLabel)
        
        NSLayoutConstraint.activate([
            progressViewLabel.topAnchor.constraint(equalTo: studyProgressView.topAnchor, constant: 40.5),
            progressViewLabel.trailingAnchor.constraint(equalTo: studyProgressView.trailingAnchor, constant: -14)
        ])
        
        // MARK: - progressValueLabel progress 숫자
        
        progressValueLabel.text = "\(Int(progress * 100))"
        progressValueLabel.translatesAutoresizingMaskIntoConstraints = false
        studyProgressView.addSubview(progressValueLabel)
        
        NSLayoutConstraint.activate([
            progressValueLabel.trailingAnchor.constraint(equalTo: progressViewLabel.leadingAnchor),
            progressValueLabel.centerYAnchor.constraint(equalTo: progressViewLabel.centerYAnchor),
        ])
        
        // MARK: - progressView UIProgressView막대기
        
        progressView.progress = progress
        progressView.translatesAutoresizingMaskIntoConstraints = false
        studyProgressView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: studyProgressView.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: progressValueLabel.leadingAnchor, constant: -22),
            progressView.centerYAnchor.constraint(equalTo: progressViewLabel.centerYAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 12),
        ])
        
        // MARK: - headerBookmarkButton 오답노트 버튼
        
        headerBookmarkButton.addTarget(self, action: #selector(bookMarkButtonTapped), for: .touchUpInside)
        headerBookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        studyProgressView.addSubview(headerBookmarkButton)
        
        NSLayoutConstraint.activate([
            headerBookmarkButton.leadingAnchor.constraint(equalTo: studyProgressView.leadingAnchor, constant: 36),
            headerBookmarkButton.trailingAnchor.constraint(equalTo: studyProgressView.trailingAnchor, constant: -36),
            headerBookmarkButton.bottomAnchor.constraint(equalTo: studyProgressView.bottomAnchor, constant: -16),
            headerBookmarkButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // MARK: - progressImage 경찰배찌 UIImageView
        
        progressImages.translatesAutoresizingMaskIntoConstraints = false
        studyProgressView.addSubview(progressImages)
        
        NSLayoutConstraint.activate([
            progressImages.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
//            progressImages.leadingAnchor.constraint(equalTo: progressView.leadingAnchor)
        ])
        
        return header
    }
}
// MARK: - HomeViewButtonTapped 버튼 클릭
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
    
    @objc func bookMarkButtonTapped() {
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

// MARK: - navigation 관련 세팅
extension HomeViewController {
    func homeViewNavBar() {
        self.title = "조현 경찰학"
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .regular)
        let symbolImage = UIImage(systemName: "book.fill", withConfiguration: symbolConfiguration)
        
        let rightBarButtonItem = UIBarButtonItem(
            image: symbolImage,
            style: .plain,
            target: self,
            action: #selector(rightItemTapped)
        )
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
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

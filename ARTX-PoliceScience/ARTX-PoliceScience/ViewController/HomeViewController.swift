//
//  HomeViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var newLeadingConstraint: NSLayoutConstraint?
    
    var observeProgress: NSKeyValueObservation?
    var observeProgressViewWidth: NSKeyValueObservation?
    
    @objc dynamic var progress: Float = 0.0
    @objc dynamic var progressViewWidth: CGFloat = 0.0
    
    var safeAreaLength = 0
    var isScrollEnabled = true
    
    // MARK: - TableView
    private let homeTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(HomeViewCell.self, forCellReuseIdentifier: HomeViewCell.identifier)
        return table
    }()
    
    // MARK: - Header View
    let headerBackImage: UIImageView = {
        let headerBackImage = UIImageView()
        headerBackImage.image = .mainViewTop
        headerBackImage.contentMode = .scaleAspectFill
        return headerBackImage
    }()
    
    let settingViewButton: UIButton = {
        let settingButton = UIButton(type: .custom)
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 22)
        settingButton.setImage(UIImage(systemName: "gearshape.fill", withConfiguration: symbolConfiguration), for: .normal)
        settingButton.tintColor = .white
        return settingButton
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "조현 경찰학"
        titleLabel.textColor = .white
        titleLabel.font = .gmarketBold
        return titleLabel
    }()
    
    let subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.text = "OX 문제집"
        subTitleLabel.textColor = .white
        subTitleLabel.font = .gmarketMedium
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
        studyProgressView.layer.shadowColor = UIColor(red: 0.102, green: 0.176, blue: 0.561, alpha: 0.1).cgColor
        studyProgressView.layer.shadowOpacity = 1
        studyProgressView.layer.shadowOffset = CGSize(width: 4, height: 4)
        studyProgressView.layer.shadowRadius = 8
        studyProgressView.layer.masksToBounds = false
        
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
        let headerBookmarkButton = UIButton(type: .system)
        headerBookmarkButton.layer.cornerRadius = 20
        headerBookmarkButton.clipsToBounds = true
        headerBookmarkButton.layer.borderWidth = 1
        headerBookmarkButton.layer.borderColor = UIColor.textBlue.cgColor
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold)
        if let image = UIImage(systemName: "book.fill")?.withConfiguration(symbolConfiguration) {
            headerBookmarkButton.setImage(image, for: .normal)
        }
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
//        progressImage.image = .gradeBadge0
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
        //        print("ViewDidAppear 실행")
        
        super.viewDidAppear(animated)
        
        progressImages.image = HomeViewModel.selectProgressImages(progress: calculateProgress())
        
        progressView.progress = calculateProgress()
        let newLeadingConstant = (progressView.frame.size.width * CGFloat(progressView.progress)) - 11
        print(progressImages.frame.size.width)
        
        // Deactivate the old constraint before creating a new one
        newLeadingConstraint?.isActive = false
        
        newLeadingConstraint = progressImages.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: newLeadingConstant)
        newLeadingConstraint?.isActive = true
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
        
        
        print(newLeadingConstant)
    }
    
    
    
    override func viewDidLoad() {
        progressImages.image = HomeViewModel.selectProgressImages(progress: calculateProgress())
        
        super.viewDidLoad()
        homeViewNavBar()
        navigationController?.isNavigationBarHidden = true
        
        header = tableHeaderView()
        homeTableView.tableHeaderView = header
        updateViewsForProgress(calculateProgress())
        
        NotificationCenter.default.addObserver(self, selector: #selector(rerenderTableCell), name: Notification.Name("changeQuizToHomeview"), object: nil)
        
        view.addSubview(homeTableView)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.frame = view.bounds
        homeTableView.contentInsetAdjustmentBehavior = .never
        
        newLeadingConstraint?.isActive = false
        
        newLeadingConstraint = progressImages.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: -11)
        newLeadingConstraint?.isActive = true
        
        progressFunction()
        
    }
    
    func calculateProgress() -> Float{
        var totalQuestionNum = Float(totalQuestionNumber)
        var totalSolveQuestionNum = Float(PartChapter.totalCurrentSolveQuestionNum())
        return (totalSolveQuestionNum/totalQuestionNum)
    }
    
    func progressFunction() {
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
        //        progressView.progress = newProgress
        print(progressView.frame.size.width)
        
        
    }
    
    @objc func rerenderTableCell() {
        OperationQueue.main.addOperation { // DispatchQueue도 가능.
            self.homeTableView.reloadData()
            self.progress = self.calculateProgress()
        }
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
            studyProgressView.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16),
            studyProgressView.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -16),
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
            progressView.trailingAnchor.constraint(equalTo: studyProgressView.trailingAnchor, constant: -92),
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
            //                        progressImages.leadingAnchor.constraint(equalTo: progressView.leadingAnchor)
        ])
        
        return header
    }
}
// MARK: - HomeViewButtonTapped 버튼 클릭
extension HomeViewController {
    
    @objc func SettingButtonTapped() {
        isScrollEnabled = false
        navigationController?.pushViewController(SettingViewModel.settingViewController, animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc func introduceButtonTapped() {
        isScrollEnabled = false
        navigationController?.pushViewController(BookViewController(), animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc func rightItemTapped() {
        isScrollEnabled = false
        navigationController?.pushViewController(BookmarkViewController(), animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc func bookMarkButtonTapped() {
        navigationController?.pushViewController(BookmarkViewController(), animated: true)
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
            withIdentifier: HomeViewCell.identifier,
            for: indexPath
        ) as? HomeViewCell else {
            return UITableViewCell()
        }
        cell.separatorInset = UIEdgeInsets.zero
        
        let partChaper = PartChapter.partIntToString(partIndex: indexPath.section, chapterIndex: indexPath.row)
        
        if LocalState.isCodeActivated {
            cell.configure(with: quizChapterModel, partChapter: partChaper, undisabled: true)
        } else {
            if indexPath.section <= 1 {
                cell.configure(with: quizChapterModel, partChapter: partChaper, undisabled: true)
            } else {
                cell.configure(with: quizChapterModel, partChapter: partChaper, undisabled: false)
            }
        }
        
        if indexPath.section <= 1 {
            
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print("\(indexPath.section), \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        
        let partIndexString = PartChapter.partIntToString(partIndex: indexPath.section, chapterIndex: indexPath.row)
        let currentQuizNumber = UserDefaults.standard.integer(forKey: partIndexString)
        let totalQuizNumber = globalQuestion.quiz[indexPath.section].chapters[indexPath.row].questions.count
        let quizViewController = QuizViewController(partNumber: indexPath.section, partTitle: globalQuestion.quiz[indexPath.section].part_name, chapter: globalQuestion.quiz[indexPath.section].chapters[indexPath.row], currentQuizNumber: currentQuizNumber)
        
        if indexPath.section > 1 && !LocalState.isCodeActivated {
            HomeViewAlert.needActivateAlert(from: self)
        } else {
            switch currentQuizNumber {
            case 0:
                quizViewController.delegate = self
                navigationController?.pushViewController(quizViewController, animated: true)
                navigationController?.isNavigationBarHidden = false
            case totalQuizNumber:
                HomeViewAlert.restartAlert(from: self, indexPath: indexPath)
            default:
                HomeViewAlert.continueAlert(from: self, indexPath: indexPath, currentQuizNumber: currentQuizNumber)
            }
        }
        
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

extension HomeViewController: QuizViewConrollerDelegate {
    private func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 14.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 10.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func chapterFinished() {
        showToast(message: "학습을 완료하였습니다!")
    }
}

//
//  QuizViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class QuizViewController: UIViewController, UISheetPresentationControllerDelegate {
    
    var safeAreaLength = 0
    var indexPath: IndexPath
    var showBookmarkedOnly: Bool = false
    var questions: [Question]
    var bookmarkQuizNumber = 0
    lazy var partIndex = indexPath[0]
    lazy var chapterIndex = indexPath[1]
    lazy var partPath = globalQuestion.quiz[partIndex]
    lazy var chapterPath = partPath.chapters[chapterIndex]
    lazy var partIndexString = PartChapter.partIntToString(partIndex: partIndex, chapterIndex: chapterIndex)
    lazy var currentQuizNumber = UserDefaults.standard.integer(forKey: partIndexString)


    weak var delegate: QuizViewConrollerDelegate?
    
    //MARK: - View
    private let titleView = QuizTitleView()
    private let progressbarView = QuizProgressView()
    private let quizView = QuizView()
    private let oxbuttonView = OXbuttonView()
    private let navBackView: UIView = {
        let settingNavBackView = UIView()
        settingNavBackView.translatesAutoresizingMaskIntoConstraints = false
        settingNavBackView.backgroundColor = .pointBg
        
        return settingNavBackView
    }()
    
    //MARK: - init
    init(indexPath: IndexPath, showBookmarkedOnly: Bool, questions: [Question]) {
        self.indexPath = indexPath
        self.showBookmarkedOnly = showBookmarkedOnly
        self.questions = questions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let window = UIApplication.shared.windows.first {
            safeAreaLength = Int(window.safeAreaInsets.top)
        }
        
        navigationController?.configureNavigationBar(withTitle: "0\(partPath.part) \(partPath.part_name)")
        navigationController?.addBackButton(target: self, action: #selector(backButtonTapped))
        
        if showBookmarkedOnly {
            currentQuizNumber = 0
        } else {
            currentQuizNumber = UserDefaults.standard.integer(forKey: partIndexString)
        }
        
        update()
        layout()

        oxbuttonView.correctButton.addTarget(self, action: #selector(correctButtonTapped), for: .touchUpInside)
        oxbuttonView.wrongButton.addTarget(self, action: #selector(wrongButtonTapped), for: .touchUpInside)
        quizView.bookMarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        
        oxbuttonView.correctButton.addTarget(self, action: #selector(correctButtonDownTapped), for: .touchDown)
        oxbuttonView.wrongButton.addTarget(self, action: #selector(wrongButtonDownTapped), for: .touchDown)
        
        oxbuttonView.correctButton.addTarget(self, action: #selector(outsideTapped), for: .touchDragExit)
        oxbuttonView.wrongButton.addTarget(self, action: #selector(outsideTapped), for: .touchDragExit)
        
        oxbuttonView.correctButton.addTarget(self, action: #selector(outsideTapped), for: .touchUpInside)
        oxbuttonView.wrongButton.addTarget(self, action: #selector(outsideTapped), for: .touchUpInside)
        
        // 업데이트 Observer
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveTestNotification(_:)), name: NSNotification.Name("CurentQuizNumberDidChange"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToHomeView(_:)), name: NSNotification.Name("QuizToHomeView"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(backButtonTapped), name: NSNotification.Name("changeQuizToHomeview"), object: nil)

    }
    
    // 업데이트 함수
    private func update() {
            let number = showBookmarkedOnly ? bookmarkQuizNumber : currentQuizNumber
            quizView.quizNumber = questions[number].index
            quizView.quiz = questions[number].question
            progressbarView.currentQuizNumber = number
            progressbarView.totalNumber = questions.count
            progressbarView.progressNum = Float(number) / Float(questions.count)
        
        let imageName = LocalState.bookmarkList.contains(QuizId()) ? "bookmark.fill" : "bookmark"
        let configuration = UIImage.SymbolConfiguration(font: UIFont.bodyBold)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        quizView.bookMarkButton.setImage(image, for: .normal)
    }
}


extension QuizViewController {
    
    @objc func wrongButtonTapped() {
        presentQuizModal(selectedAnswer: false)
    }
    
    @objc func correctButtonTapped() {
        presentQuizModal(selectedAnswer: true)
    }
    
    @objc func bookmarkButtonTapped() {
        let quizId = QuizId()
        CustomHaptics.shared.bookMarkTapped()
        
        if !LocalState.bookmarkList.contains(quizId) {
            LocalState.bookmarkList.append(quizId)
        } else {
            LocalState.bookmarkList = LocalState.bookmarkList.filter { $0 != quizId }
        }
        update()
    }
    
    func bookmarkDidChange() {
        // 북마크 상태가 변경되었을 때 UI를 업데이트하거나 필요한 동작을 수행
        let quizId = QuizId()
        quizView.bookMarkButton.isSelected = LocalState.bookmarkList.contains(quizId)
    }
    
    @objc func backButtonTapped() {
        let text = QuizBackAlertText.self
        
        let alert = UIAlertController(title: text.title, message: text.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: text.cancelButton, style: .cancel))
        alert.addAction(UIAlertAction(title: text.button, style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.isNavigationBarHidden = true
//            NotificationCenter.default.post(name: Notification.Name("changeQuizToHomeview"), object: nil)
            if self.showBookmarkedOnly {
                NotificationCenter.default.post(name: Notification.Name("BackToOxListview"), object: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name("changeToHomeview"), object: nil)
            }
        })
        
        alert.show()
    }
    
    private func layout() {
        
        view.backgroundColor = .bgPrimary
        
        view.addSubview(navBackView)
        view.addSubview(titleView.chapterStackView)
        view.addSubview(progressbarView.progressView)
        view.addSubview(progressbarView.progressNumberLabel)
        view.addSubview(progressbarView.imageView)
        view.addSubview(quizView.quizBackgroundView)
        view.addSubview(quizView.quizTitlBackgroundView)
        view.addSubview(quizView.quizNumberLabel)
        view.addSubview(quizView.bookMarkButton)
        view.addSubview(quizView.quizLabel)
        view.addSubview(oxbuttonView.buttonStackView)

        titleView.chapterStackView.addArrangedSubview(titleView.chapterNumberLabel)
        titleView.chapterStackView.addArrangedSubview(titleView.chapterTitleLabel)
        
        oxbuttonView.buttonStackView.addArrangedSubview(oxbuttonView.correctButton)
        oxbuttonView.buttonStackView.addArrangedSubview(oxbuttonView.wrongButton)
        
        titleView.chapterNumber = chapterPath.chapter
        titleView.chapterName = chapterPath.chapter_name
        
        NSLayoutConstraint.activate([
            navBackView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            navBackView.heightAnchor.constraint(equalToConstant: navigationController!.navigationBar.frame.size.height + CGFloat(safeAreaLength)),
            
            titleView.chapterStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleView.chapterStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            
            progressbarView.progressView.topAnchor.constraint(equalTo: titleView.chapterStackView.bottomAnchor, constant: 24),
            progressbarView.progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            progressbarView.progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -104),
            progressbarView.progressView.heightAnchor.constraint(equalToConstant: 8),
            
            progressbarView.progressNumberLabel.centerYAnchor.constraint(equalTo: progressbarView.progressView.centerYAnchor),
            progressbarView.progressNumberLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -54),
            
            progressbarView.imageView.centerYAnchor.constraint(equalTo: progressbarView.progressView.centerYAnchor),
            progressbarView.imageView.leadingAnchor.constraint(equalTo: progressbarView.progressNumberLabel.trailingAnchor, constant: 10),
            progressbarView.imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            quizView.quizBackgroundView.topAnchor.constraint(equalTo: progressbarView.progressView.bottomAnchor, constant: 26),
            quizView.quizBackgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            quizView.quizBackgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            quizView.quizBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -206),
            
            quizView.quizTitlBackgroundView.topAnchor.constraint(equalTo: quizView.quizBackgroundView.topAnchor, constant: 26),
            quizView.quizTitlBackgroundView.leadingAnchor.constraint(equalTo: quizView.quizBackgroundView.leadingAnchor, constant: 26),
            quizView.quizTitlBackgroundView.trailingAnchor.constraint(equalTo: quizView.quizBackgroundView.trailingAnchor, constant: -26),
            quizView.quizTitlBackgroundView.heightAnchor.constraint(equalToConstant: 40),
            
            quizView.quizNumberLabel.topAnchor.constraint(equalTo: quizView.quizTitlBackgroundView.topAnchor, constant: 9),
            quizView.quizNumberLabel.bottomAnchor.constraint(equalTo: quizView.quizTitlBackgroundView.bottomAnchor, constant: -9),
            quizView.quizNumberLabel.leadingAnchor.constraint(equalTo: quizView.quizTitlBackgroundView.leadingAnchor, constant: 10),
            
            quizView.bookMarkButton.centerYAnchor.constraint(equalTo: quizView.quizNumberLabel.centerYAnchor),
            //quizView.bookMarkButton.leadingAnchor.constraint(equalTo: quizView.quizNumberLabel.trailingAnchor, constant: 217.5),
            quizView.bookMarkButton.trailingAnchor.constraint(equalTo: quizView.quizTitlBackgroundView.trailingAnchor, constant: -10.5),
            
            quizView.quizLabel.leadingAnchor.constraint(equalTo: quizView.quizTitlBackgroundView.leadingAnchor, constant: 8),
            quizView.quizLabel.trailingAnchor.constraint(equalTo: quizView.quizTitlBackgroundView.trailingAnchor, constant: -8),
            quizView.quizLabel.topAnchor.constraint(equalTo: quizView.quizTitlBackgroundView.bottomAnchor, constant: 16),
            quizView.quizLabel.bottomAnchor.constraint(equalTo: quizView.quizBackgroundView.bottomAnchor, constant: -26),
            
            oxbuttonView.buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            oxbuttonView.buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            oxbuttonView.buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -21),
            oxbuttonView.buttonStackView.topAnchor.constraint(equalTo: quizView.quizBackgroundView.bottomAnchor, constant: 55),
            
        ])
    }
    
    func setupSheetPresentation(for quizModal: QuizModalViewController) {
        if let sheet = quizModal.sheetPresentationController {
            let height = view.frame.height
            let multiplier = 0.42
            
            if #available(iOS 16.0, *) {
                let fraction = UISheetPresentationController.Detent.custom { context in
                    height * multiplier
                }
                sheet.detents = [fraction]
            } else {
                sheet.detents = [.medium()]
                sheet.delegate = self
                sheet.prefersGrabberVisible = false
            }
        }
    }
    
    private func presentQuizModal(selectedAnswer: Bool) {
        let quizModal = QuizModalViewController(indexPath: indexPath, selectedAnswer: selectedAnswer, partIndexString: partIndexString, questions: questions, showBookmarkedOnly: showBookmarkedOnly, bookmarkQuizNumber: bookmarkQuizNumber)
        setupSheetPresentation(for: quizModal)
        present(quizModal, animated: true, completion: nil)
    }
    
    @objc func didRecieveTestNotification(_ notification: Notification) {
        if showBookmarkedOnly {
            self.bookmarkQuizNumber += 1
        } else {
            self.currentQuizNumber += 1
        }
        update()
    }
    
    @objc func goToHomeView(_ notification: Notification) {
        self.navigationController?.popViewController(animated: true)
        progressbarView.progressNum = 1.0
        progressbarView.progressNumberLabel.text = " \(questions.count) / \(questions.count)"
    }
    
    
    @objc func outsideTapped() {
        oxbuttonView.correctButton.backgroundColor = .pointGray
        
        oxbuttonView.correctButton.layer.shadowColor = UIColor(red: 0.102, green: 0.176, blue: 0.561, alpha: 0.25).cgColor
        oxbuttonView.correctButton.layer.shadowOpacity = 1
        oxbuttonView.correctButton.layer.shadowRadius = 4
        oxbuttonView.correctButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        oxbuttonView.wrongButton.backgroundColor = .pointGray
        
        oxbuttonView.wrongButton.layer.shadowColor = UIColor(red: 0.102, green: 0.176, blue: 0.561, alpha: 0.25).cgColor
        oxbuttonView.wrongButton.layer.shadowOpacity = 1
        oxbuttonView.wrongButton.layer.shadowRadius = 4
        oxbuttonView.wrongButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        CustomHaptics.shared.oxUntapped()
    }
    
    @objc func wrongButtonDownTapped() {
        oxbuttonView.wrongButton.backgroundColor = .buttonRed
        
        oxbuttonView.wrongButton.layer.shadowColor = UIColor(red: 0.102, green: 0.176, blue: 0.561, alpha: 0.15).cgColor
        oxbuttonView.wrongButton.layer.shadowOpacity = 1
        oxbuttonView.wrongButton.layer.shadowRadius = 4
        oxbuttonView.wrongButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        CustomHaptics.shared.oxTapped()
    }
    
    @objc func correctButtonDownTapped() {
        oxbuttonView.correctButton.backgroundColor = .buttonBlue
        
        oxbuttonView.correctButton.layer.shadowColor = UIColor(red: 0.102, green: 0.176, blue: 0.561, alpha: 0.15).cgColor
        oxbuttonView.correctButton.layer.shadowOpacity = 1
        oxbuttonView.correctButton.layer.shadowRadius = 4
        oxbuttonView.correctButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        CustomHaptics.shared.oxTapped()
    }
    
    
    func QuizId() -> String {
        let quizId = String(format: "%02d", partPath.part)
        + String(format: "%02d", chapterPath.chapter)
        + String(format: "%03d", questions[showBookmarkedOnly ? bookmarkQuizNumber : currentQuizNumber].index)
        
        return quizId
    }
}

protocol QuizViewConrollerDelegate: AnyObject {
    func chapterFinished()
}

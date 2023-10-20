//
//  QuizViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class QuizViewController: UIViewController,DeliveryDataProtocol, UISheetPresentationControllerDelegate {
    var safeAreaLength = 0
    let partNumber: Int
    let partTitle: String
    //let userdefaultNumber: UserDefaults.standard.integer(forKey: partIndexString)
    
    let nextQuiz: Notification.Name = Notification.Name("nextQuiz")
    
    private var currentQuizNumber: Int = 0
    
    private let titleView = QuizTitleView()
    private let progressbarView = QuizProgressView()
    private let quizView = QuizView()
    private let oxbuttonView = OXbuttonView()
    private let viewmodel: QuizViewModel
    weak var delegate: QuizViewConrollerDelegate?
    
    private let navBackView: UIView = {
        
        let settingNavBackView = UIView()
        settingNavBackView.translatesAutoresizingMaskIntoConstraints = false
        settingNavBackView.backgroundColor = .bgBlue
        
        return settingNavBackView
    }()
    
    init(partNumber: Int, partTitle: String, chapter: Chapter, currentQuizNumber: Int) {
        self.partNumber = partNumber
        self.partTitle = partTitle
        self.viewmodel = QuizViewModel(chapter: chapter)
        self.currentQuizNumber = currentQuizNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let window = UIApplication.shared.windows.first {
            safeAreaLength = Int(window.safeAreaInsets.top)
        }
        
        view.backgroundColor = .bgPrimary
        navigationController?.configureNavigationBar(withTitle: "0\(partNumber+1) \(partTitle)")
        navigationController?.addBackButton(target: self, action: #selector(backButtonTapped))
        
        quizView.addBookmark = { isSelected in
            var currentBookmarkList = LocalState.bookmarkList
            
            let quizId = self.QuizId()
            
            if isSelected {
                currentBookmarkList.append(quizId)
            } else {
                guard let bookmarkIndex = currentBookmarkList.firstIndex(of: quizId) else { return }
                currentBookmarkList.remove(at: bookmarkIndex)
            }
            LocalState.bookmarkList = currentBookmarkList
        }
        
        oxbuttonView.correctButton.addTarget(self, action: #selector(correctButtonTapped), for: .touchUpInside)
        oxbuttonView.wrongButton.addTarget(self, action: #selector(wrongButtonTapped), for: .touchUpInside)
        
        oxbuttonView.correctButton.addTarget(self, action: #selector(correctButtonDownTapped), for: .touchDown)
        oxbuttonView.wrongButton.addTarget(self, action: #selector(wrongButtonDownTapped), for: .touchDown)
        
        oxbuttonView.correctButton.addTarget(self, action: #selector(OutsideTapped), for: .touchDragExit)
        oxbuttonView.wrongButton.addTarget(self, action: #selector(OutsideTapped), for: .touchDragExit)
        
        oxbuttonView.correctButton.addTarget(self, action: #selector(OutsideTapped), for: .touchUpInside)
        oxbuttonView.wrongButton.addTarget(self, action: #selector(OutsideTapped), for: .touchUpInside)
        
        update()
        layout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.nextQuiz(_:)), name: nextQuiz, object: nil)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    private func layout() {
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
            progressbarView.progressNumberLabel.leadingAnchor.constraint(equalTo: progressbarView.progressView.trailingAnchor, constant: 10),
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
            //quizView.quizNumberLabel.trailingAnchor.constraint(equalTo: quizView.quizTitlBackgroundView.trailingAnchor, constant: -247),
            
            
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
    
    private func update() {
        //        print("여기는\(currentQuizNumber)")
        let totalQuestions = globalQuestion.quiz[partNumber].chapters[viewmodel.chapterNumber(to: currentQuizNumber)-1].questions.count
        let progressFraction = Float(currentQuizNumber+1) / Float(totalQuestions)
        var progressbar = progressFraction
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            let updatedProgressFraction = Float(self.currentQuizNumber) / Float(totalQuestions)
            self.progressbarView.progressView.setProgress(updatedProgressFraction, animated: true)
        }
        titleView.chapterNumberLabel.text = "CHAPTER 0" + String( viewmodel.chapterNumber(to: self.currentQuizNumber))
        titleView.chapterTitleLabel.text = viewmodel.chapterTitle(to: self.currentQuizNumber)
        quizView.quizNumberLabel.text = ("Quiz \(self.currentQuizNumber+1)")
        quizView.quizLabel.text = viewmodel.question(to: self.currentQuizNumber).question
        
        let quizId = self.QuizId()
        
        
        if LocalState.bookmarkList.contains(quizId) {
            quizView.bookMarkButton.setImage(UIImage(systemName: "bookmark.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)), for: .normal)
            quizView.bookMarkButton.isSelected = true
        } else {
            quizView.bookMarkButton.setImage(UIImage(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)), for: .normal)
            quizView.bookMarkButton.isSelected = false
        }
        
        progressbarView.progressNumberLabel.text = "\(currentQuizNumber) / \(totalQuestions)"
    }
    
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
    func deliveryData(_ data: String) {
        
    }
}

extension QuizViewController {
    @objc func backButtonTapped() {
        let text = QuizBackAlertText.self
        
        let alert = UIAlertController(title: text.title, message: text.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: text.cancelButton, style: .cancel))
        alert.addAction(UIAlertAction(title: text.button, style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            NotificationCenter.default.post(name: Notification.Name("changeQuizToHomeview"), object: nil)
        })
        
        alert.show()
    }
    
    @objc func nextQuestionButtonTapped() {
        self.dismiss(animated: true) { [weak self] in
            NotificationCenter.default.post(name: self!.nextQuiz, object: nil, userInfo: nil)
        }
        oxbuttonView.wrongButton.backgroundColor = .pointGray
        
        oxbuttonView.wrongButton.layer.shadowColor = UIColor(red: 0.102, green: 0.176, blue: 0.561, alpha: 0.25).cgColor
        oxbuttonView.wrongButton.layer.shadowOpacity = 1
        oxbuttonView.wrongButton.layer.shadowRadius = 4
        oxbuttonView.wrongButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        oxbuttonView.correctButton.backgroundColor = .pointGray
        
        oxbuttonView.correctButton.layer.shadowColor = UIColor(red: 0.102, green: 0.176, blue: 0.561, alpha: 0.25).cgColor
        oxbuttonView.correctButton.layer.shadowOpacity = 1
        oxbuttonView.correctButton.layer.shadowRadius = 4
        oxbuttonView.correctButton.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    @objc func wrongButtonTapped() {
        let quizId = QuizId()
        let quizModal = QuizModalViewController(quizId: quizId, question: viewmodel.question(to: self.currentQuizNumber), selectedAnswer: false)
        //        quizModal.quizModalView.nextQuestionButton.addTarget(self, action: #selector(nextQuestionButtonTapped), for: .touchUpInside)
        quizModal.quizeNumberPlusClosure = nextQuestionButtonTapped
        quizModal.modalPresentationStyle = .pageSheet
        quizModal.transitioningDelegate = self
        
        if LocalState.bookmarkList.contains(quizId) {
            quizModal.quizModalView.bookMarkButton.setImage(UIImage(systemName: "bookmark.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)), for: .normal)
            quizModal.quizModalView.bookMarkButton.isSelected = true
        } else {
            quizModal.quizModalView.bookMarkButton.setImage(UIImage(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)), for: .normal)
            quizModal.quizModalView.bookMarkButton.isSelected = false
        }
        
        
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
        
        present(quizModal, animated: true, completion: nil)
    }
    
    @objc func correctButtonTapped() {
        let quizId = QuizId()
        let quizModal = QuizModalViewController(quizId: quizId, question: viewmodel.question(to: self.currentQuizNumber), selectedAnswer: true)
        //        quizModal.quizModalView.nextQuestionButton.addTarget(self, action: #selector(nextQuestionButtonTapped), for: .touchUpInside)
        quizModal.quizeNumberPlusClosure = nextQuestionButtonTapped
        quizModal.modalPresentationStyle = .pageSheet
        quizModal.transitioningDelegate = self
        
        if LocalState.bookmarkList.contains(quizId) {
            quizModal.quizModalView.bookMarkButton.setImage(UIImage(systemName: "bookmark.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)), for: .normal)
            quizModal.quizModalView.bookMarkButton.isSelected = true
        } else {
            quizModal.quizModalView.bookMarkButton.setImage(UIImage(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)), for: .normal)
            quizModal.quizModalView.bookMarkButton.isSelected = false
        }
        
        
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
        
        present(quizModal, animated: true, completion: nil)
    }
    
    
    
    @objc func OutsideTapped() {
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
    
    @objc func nextQuiz(_ noti: Notification) {
        let totalQuestions = globalQuestion.quiz[partNumber].chapters[viewmodel.chapterNumber(to: currentQuizNumber)-1].questions.count
        var solving = PartChapter.partIntToString(partIndex: self.partNumber, chapterIndex: self.viewmodel.chapterNumber(to: self.currentQuizNumber)-1)
        if currentQuizNumber + 1 == totalQuestions {
            print("여기는\(currentQuizNumber)")
            UserDefaults.standard.set(currentQuizNumber + 1, forKey: solving)
            self.navigationController?.popViewController(animated: true)
            //            navigationController?.pushViewController(HomeViewController(), animated: true)
            NotificationCenter.default.post(name: Notification.Name("changeQuizToHomeview"), object: nil)
            delegate?.chapterFinished()
        } else {
            currentQuizNumber += 1
            update()
            UserDefaults.standard.set(self.currentQuizNumber, forKey: solving)
        }
    }
    
    func QuizId() -> String {
        let quizId = String(format: "%02d", self.partNumber+1)
        + String(format: "%02d", self.viewmodel.chapterNumber(to: 0))
        + String(format: "%03d", self.viewmodel.question(to: self.currentQuizNumber).index)
        
        return quizId
    }
}

extension QuizViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

protocol DeliveryDataProtocol: class {
    func deliveryData(_ data: String)
}

protocol QuizViewConrollerDelegate: AnyObject {
    func chapterFinished()
}

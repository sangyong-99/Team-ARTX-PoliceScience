//
//  QuizViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class QuizViewController: UIViewController {
    
    let partNumber: Int
    let partTitle: String
    
    let nextQuiz: Notification.Name = Notification.Name("nextQuiz")
    
    private var currentQuizNumber: Int = 0
    
    private let titleView = QuizTitleView()
    private let progressbarView = QuizProgressView()
    private let quizView = QuizView()
    private let oxbuttonView = OXbuttonView()
    private let viewmodel: QuizViewModel
    
    private let quizModal = QuizModalViewController()
    
    init(partNumber: Int, partTitle: String, chapter: Chapter, currentQuizNumber: Int) {
        self.partNumber = partNumber
        self.partTitle = partTitle
        self.viewmodel = QuizViewModel(chapter: chapter)
        self.currentQuizNumber = currentQuizNumber
        print(currentQuizNumber)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemGray5
        navigationController?.configureNavigationBar(withTitle: "01 경찰학의 기초이론")
        navigationController?.addBackButton(target: self, action: #selector(backButtonTapped))
        
        oxbuttonView.correctButton.addTarget(self, action: #selector(correctButtonTapped), for: .touchUpInside)
        oxbuttonView.wrongButton.addTarget(self, action: #selector(wrongButtonTapped), for: .touchUpInside)
        quizModal.quizModalView.nextQuestionButton.addTarget(self, action: #selector(nextQuestionButtonTapped), for: .touchUpInside)
        update()
        layout()
        //update()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.nextQuiz(_:)), name: nextQuiz, object: nil)
    }
    
    private func layout() {
        
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
            titleView.chapterStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleView.chapterStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            
            progressbarView.progressView.topAnchor.constraint(equalTo: titleView.chapterStackView.bottomAnchor, constant: 24),
            progressbarView.progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            progressbarView.progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -104),
            
            progressbarView.progressNumberLabel.centerYAnchor.constraint(equalTo: progressbarView.progressView.centerYAnchor),
            progressbarView.progressNumberLabel.leadingAnchor.constraint(equalTo: progressbarView.progressView.trailingAnchor, constant: 10),
            progressbarView.progressNumberLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -54),
            
            progressbarView.imageView.centerYAnchor.constraint(equalTo: progressbarView.progressView.centerYAnchor),
            progressbarView.imageView.leadingAnchor.constraint(equalTo: progressbarView.progressNumberLabel.trailingAnchor, constant: 10),
            progressbarView.imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            quizView.quizBackgroundView.topAnchor.constraint(equalTo: progressbarView.progressView.bottomAnchor, constant: 16),
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
            quizView.quizNumberLabel.trailingAnchor.constraint(equalTo: quizView.quizTitlBackgroundView.trailingAnchor, constant: -247),
            
            
            quizView.bookMarkButton.centerYAnchor.constraint(equalTo: quizView.quizNumberLabel.centerYAnchor),
            quizView.bookMarkButton.leadingAnchor.constraint(equalTo: quizView.quizNumberLabel.trailingAnchor, constant: 217.5),
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
        //title 관련 정보는 HomeView에서 넘어올때 받아오는걸로
        //json파일에 quiznumber추가하면 업뎃 예정
        titleView.chapterNumberLabel.text = String( viewmodel.chapterNumber(to: self.currentQuizNumber))
        titleView.chapterTitleLabel.text = viewmodel.chapterTitle(to: self.currentQuizNumber)
        quizView.quizNumberLabel.text = ("Quiz \(self.currentQuizNumber+1)")
        quizView.quizLabel.text = viewmodel.question(to: self.currentQuizNumber)
    }
}

extension QuizViewController {
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc func nextQuestionButtonTapped() {
        //self.currentQuizNumber += 1
        //if else로 마지막 문제인지 아닌지 판단해야하는데 어케할지 고민
        self.dismiss(animated: true) { [weak self] in
            NotificationCenter.default.post(name: self!.nextQuiz, object: nil, userInfo: nil)
            //print(self?.currentQuizNumber)
        }
    }
    
    @objc func wrongButtonTapped() {
        quizModal.modalPresentationStyle = .custom
        quizModal.transitioningDelegate = self
        present(quizModal, animated: true, completion: nil)
    }
    
    @objc func correctButtonTapped() {
        quizModal.modalPresentationStyle = .custom
        quizModal.transitioningDelegate = self
        present(quizModal, animated: true, completion: nil)
    }
    
    @objc func nextQuiz(_ noti: Notification) {
        currentQuizNumber += 1
        update()
        var solving = PartChapter.partIntToString(partIndex: self.partNumber-1, chapterIndex: self.viewmodel.chapterNumber(to: self.currentQuizNumber)-1)
        UserDefaults.standard.set(self.currentQuizNumber, forKey: solving)
        print(self.currentQuizNumber, solving)
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
          print("\(key) = \(value) \n")
        }
        //print(self.currentQuizNumber)
        //print(solving)
    }
    
}

extension QuizViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

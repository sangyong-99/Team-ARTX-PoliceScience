//
//  ModalViewController.swift
//  ARTX-PoliceScience
//
//  Created by Harry on 10/14/23.
//

import UIKit

class QuizModalViewController: UIViewController {
    
    var indexPath: IndexPath
    var selectedAnswer: Bool
    var bookmarkQuizNumber = 0
    var showBookmarkedOnly: Bool = false
    let quizModalView = QuizModalView()
    let partIndexString: String
    let questions: [Question]
    lazy var partIndex = indexPath[0]
    lazy var chapterIndex = indexPath[1]
    lazy var partPath = globalQuestion.quiz[partIndex]
    lazy var chapterPath = partPath.chapters[chapterIndex]
    lazy var currentQuizNumber = showBookmarkedOnly ? 0 : UserDefaults.standard.integer(forKey: partIndexString)
    lazy var quizPath = globalQuestion.quiz[indexPath[0]].chapters[indexPath[1]].questions[currentQuizNumber]
    lazy var quizCount = questions.count - 1
    weak var delegate: QuizViewConrollerDelegate?
    
    init(indexPath: IndexPath, selectedAnswer: Bool, partIndexString: String, questions: [Question], showBookmarkedOnly: Bool, bookmarkQuizNumber: Int) {
        self.indexPath = indexPath
        self.selectedAnswer = selectedAnswer
        self.partIndexString = partIndexString
        self.questions = questions
        self.showBookmarkedOnly = showBookmarkedOnly
        self.bookmarkQuizNumber = bookmarkQuizNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        view.backgroundColor = .white
        
        let number = showBookmarkedOnly ? bookmarkQuizNumber : currentQuizNumber
        
        
        if quizPath.answer == selectedAnswer {
            
            quizModalView.correctNotificationLabel.textColor = UIColor(resource: .textBlue)
            quizModalView.labelBackgroundView.backgroundColor = UIColor(.bgPaleBlue)
            quizModalView.correctNotificationLabel.text = "맞았습니다."
            quizModalView.correctLabel.text = questions[number].answer ? "정답: O" : "정답 X"
            quizModalView.explanationLabel.text = questions[number].explanation == "" ? "해설 없음." : questions[number].explanation
        } else {
            quizModalView.correctNotificationLabel.textColor = UIColor(resource: .textRed)
            quizModalView.labelBackgroundView.backgroundColor = UIColor(.bgPaleRed)
            quizModalView.correctNotificationLabel.text = "틀렸습니다."
            quizModalView.correctLabel.text = questions[number].answer ? "정답: O" : "정답 X"
            quizModalView.explanationLabel.text = questions[number].explanation == "" ? "해설 없음." : questions[number].explanation
        }
        
        quizModalView.nextQuestionButton.addTarget(self, action: #selector(nextQuestionButtonTapped), for: .touchUpInside)
    }
    
    @objc func nextQuestionButtonTapped() {
        if showBookmarkedOnly{
            if bookmarkQuizNumber < quizCount {
                self.dismiss(animated: true)
                NotificationCenter.default.post(name: Notification.Name("CurentQuizNumberDidChange"), object: nil)
                NotificationCenter.default.post(name: Notification.Name("BackToOxview"), object: nil)
            } else {
                self.dismiss(animated: true)
                NotificationCenter.default.post(name: Notification.Name("QuizToHomeView"), object: nil)
                NotificationCenter.default.post(name: Notification.Name("changeQuizToHomeview"), object: nil)
                NotificationCenter.default.post(name: Notification.Name("BackToOxview"), object: nil)
            }
        } else {
            if currentQuizNumber < quizCount {
                currentQuizNumber += 1
                UserDefaults.standard.set(currentQuizNumber, forKey: partIndexString)
                self.dismiss(animated: true)
                NotificationCenter.default.post(name: Notification.Name("CurentQuizNumberDidChange"), object: nil)
            } else {
                currentQuizNumber += 1
                UserDefaults.standard.set(currentQuizNumber, forKey: partIndexString)
                self.dismiss(animated: true)
                NotificationCenter.default.post(name: Notification.Name("QuizToHomeView"), object: nil)
                NotificationCenter.default.post(name: Notification.Name("changeQuizToHomeview"), object: nil)
            }
        }
    }
    
    
    func QuizId() -> String {
        let quizId = String(format: "%02d", partPath.part)
        + String(format: "%02d", chapterPath.chapter)
        + String(format: "%03d", currentQuizNumber)
        
        return quizId
    }
    
    func layout() {
        
        view.addSubview(quizModalView.labelBackgroundView)
        view.addSubview(quizModalView.correctNotificationLabel)
        view.addSubview(quizModalView.correctLabel)
        view.addSubview(quizModalView.explanationLabel)
        view.addSubview(quizModalView.nextQuestionButton)
        
        if currentQuizNumber < quizCount {
            let attributedText = NSMutableAttributedString()
            attributedText.append(NSAttributedString(string: "다음 문제", attributes: [NSAttributedString.Key.font: UIFont.subHeadBoldKR]))
            quizModalView.nextQuestionButton.setAttributedTitle(attributedText, for: .normal)
        } else {
            let attributedText = NSMutableAttributedString()
            attributedText.append(NSAttributedString(string: "학습 완료", attributes: [NSAttributedString.Key.font: UIFont.subHeadBoldKR]))
            quizModalView.nextQuestionButton.setAttributedTitle(attributedText, for: .normal)
        }
        
    
        NSLayoutConstraint.activate([
            quizModalView.labelBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            quizModalView.labelBackgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            quizModalView.labelBackgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            quizModalView.labelBackgroundView.heightAnchor.constraint(equalToConstant: 40),
            
            quizModalView.correctNotificationLabel.centerYAnchor.constraint(equalTo: quizModalView.labelBackgroundView.centerYAnchor),
            quizModalView.correctNotificationLabel.leadingAnchor.constraint(equalTo: quizModalView.labelBackgroundView.leadingAnchor, constant: 10),

            
            quizModalView.correctLabel.leadingAnchor.constraint(equalTo: quizModalView.labelBackgroundView.leadingAnchor, constant: 8),
            quizModalView.correctLabel.trailingAnchor.constraint(equalTo: quizModalView.labelBackgroundView.trailingAnchor, constant: -8),
            quizModalView.correctLabel.topAnchor.constraint(equalTo: quizModalView.labelBackgroundView.bottomAnchor, constant: 16),
            quizModalView.correctLabel.heightAnchor.constraint(equalToConstant: 40),
            
            quizModalView.explanationLabel.leadingAnchor.constraint(equalTo: quizModalView.labelBackgroundView.leadingAnchor, constant: 8),
            quizModalView.explanationLabel.trailingAnchor.constraint(equalTo: quizModalView.labelBackgroundView.trailingAnchor, constant: -8),
            quizModalView.explanationLabel.topAnchor.constraint(equalTo: quizModalView.correctLabel.bottomAnchor, constant: 0),
            quizModalView.explanationLabel.bottomAnchor.constraint(equalTo: quizModalView.nextQuestionButton.topAnchor, constant: -16),
//            quizModalView.explanationLabel.heightAnchor.constraint(equalToConstant: 105),
            
            quizModalView.nextQuestionButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            quizModalView.nextQuestionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            quizModalView.nextQuestionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42),
            quizModalView.nextQuestionButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    
}


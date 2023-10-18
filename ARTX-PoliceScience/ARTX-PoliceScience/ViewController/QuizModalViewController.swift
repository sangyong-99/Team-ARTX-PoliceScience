//
//  ModalViewController.swift
//  ARTX-PoliceScience
//
//  Created by Harry on 10/14/23.
//

import UIKit

class QuizModalViewController: UIViewController {
    
    let question: Question
    let selectedAnswer: Bool
    let quizModalView = QuizModalView()
    var quizeNumberPlusClosure: (() -> Void)?
//    weak var delegate: DeliveryDataProtocol?
    
    init(question: Question, selectedAnswer: Bool) {
        
        self.question = question
        self.selectedAnswer = selectedAnswer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        view.backgroundColor = .white
        
        if question.answer == selectedAnswer {
            quizModalView.correctNotificationLabel.textColor = UIColor(resource: .textBlue)
            quizModalView.bookMarkButton.tintColor = UIColor(resource: .pointBlue)
            quizModalView.labelBackgroundView.backgroundColor = UIColor(.bgPaleBlue)
            quizModalView.correctNotificationLabel.text = "맞았습니다."
            quizModalView.correctLabel.text = question.answer ? "정답: O" : "정답 X"
            quizModalView.explanationLabel.text = question.explanation
        } else {
            quizModalView.correctNotificationLabel.textColor = UIColor(resource: .textRed)
            quizModalView.bookMarkButton.tintColor = UIColor(resource: .pointRed)
            quizModalView.labelBackgroundView.backgroundColor = UIColor(.bgPaleRed)
            quizModalView.correctNotificationLabel.text = "틀렸습니다."
            quizModalView.correctLabel.text = question.answer ? "정답: O" : "정답 X"
            quizModalView.explanationLabel.text = question.explanation
        }
        
        quizModalView.nextQuestionButton.addTarget(self, action: #selector(nextQuestionButtonTapped), for: .touchUpInside)
    }
    
    func layout() {
        
        view.addSubview(quizModalView.labelBackgroundView)
        view.addSubview(quizModalView.correctNotificationLabel)
        view.addSubview(quizModalView.bookMarkButton)
        view.addSubview(quizModalView.correctLabel)
        view.addSubview(quizModalView.explanationLabel)
        view.addSubview(quizModalView.nextQuestionButton)
        
        NSLayoutConstraint.activate([
            quizModalView.labelBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            quizModalView.labelBackgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            quizModalView.labelBackgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            quizModalView.labelBackgroundView.heightAnchor.constraint(equalToConstant: 40),
            
            quizModalView.correctNotificationLabel.centerYAnchor.constraint(equalTo: quizModalView.labelBackgroundView.centerYAnchor),
            quizModalView.correctNotificationLabel.leadingAnchor.constraint(equalTo: quizModalView.labelBackgroundView.leadingAnchor, constant: 10),
            quizModalView.correctNotificationLabel.trailingAnchor.constraint(equalTo: quizModalView.labelBackgroundView.trailingAnchor, constant: -234),
            
            quizModalView.bookMarkButton.centerYAnchor.constraint(equalTo: quizModalView.correctNotificationLabel.centerYAnchor),
            quizModalView.bookMarkButton.leadingAnchor.constraint(equalTo: quizModalView.correctNotificationLabel.trailingAnchor, constant: 204.5),
            quizModalView.bookMarkButton.trailingAnchor.constraint(equalTo: quizModalView.labelBackgroundView.trailingAnchor, constant: -10.5),
            
            quizModalView.correctLabel.leadingAnchor.constraint(equalTo: quizModalView.labelBackgroundView.leadingAnchor, constant: 8),
            quizModalView.correctLabel.trailingAnchor.constraint(equalTo: quizModalView.labelBackgroundView.trailingAnchor, constant: -8),
            quizModalView.correctLabel.topAnchor.constraint(equalTo: quizModalView.labelBackgroundView.bottomAnchor, constant: 16),
            quizModalView.correctLabel.heightAnchor.constraint(equalToConstant: 40),
            
            quizModalView.explanationLabel.leadingAnchor.constraint(equalTo: quizModalView.labelBackgroundView.leadingAnchor, constant: 8),
            quizModalView.explanationLabel.trailingAnchor.constraint(equalTo: quizModalView.labelBackgroundView.trailingAnchor, constant: -8),
            quizModalView.explanationLabel.topAnchor.constraint(equalTo: quizModalView.correctLabel.bottomAnchor, constant: 16),
            quizModalView.explanationLabel.heightAnchor.constraint(equalToConstant: 63),
            
            quizModalView.nextQuestionButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            quizModalView.nextQuestionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            quizModalView.nextQuestionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42),
            quizModalView.nextQuestionButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    @objc func nextQuestionButtonTapped() {
//        delegate?.deliveryData("추석 연휴 스타트!!")
        self.quizeNumberPlusClosure?()
        self.dismiss(animated: true)
    }
}

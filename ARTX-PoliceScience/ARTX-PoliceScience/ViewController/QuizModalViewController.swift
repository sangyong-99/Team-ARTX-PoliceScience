//
//  ModalViewController.swift
//  ARTX-PoliceScience
//
//  Created by Harry on 10/14/23.
//

import UIKit

class QuizModalViewController: UIViewController {
    
    let quizModalView = QuizModalView()
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
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
            quizModalView.nextQuestionButton.topAnchor.constraint(equalTo: quizModalView.explanationLabel.bottomAnchor, constant: 31),
            quizModalView.nextQuestionButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}


//
//  QuizViewController.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/4/23.
//

import UIKit

class QuizViewController: UIViewController {
    
    let chapterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.axis = .vertical
        return stackView
    }()
    
    let chapterNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(named: "TextBlue")
        label.text = "CHAPTER 01"
        label.textAlignment = .center
        return label
    }()
    
    let chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(named: "PrimaryBlack")
        label.text = "경찰 개념의 연혁"
        label.textAlignment = .center
        return label
    }()
    
    let progressStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 10
        stackview.axis = .horizontal
        return stackview
    }()
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.trackTintColor = .white
        view.transform = CGAffineTransformScale(view.transform, 1, 0.2)
        view.progressTintColor = UIColor(named: "BarPoint")
        view.progress = 0.1
        return view
    }()
    
    let progressNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        label.text = "0 / 30"
        return label
    }()
    
    let badgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "IconCompletion")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let contentStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.backgroundColor = .white
        stackview.layer.cornerRadius = 14
        stackview.axis = .vertical
        return stackview
    }()
    
    let quizBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "BG GroupedPrimary")
        return view
    }()
    
    let quizTitleStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.spacing = 207
        return stackview
    }()
    
    let quizNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor(named: "PrimaryBlack")
        label.text = "Quiz 1"
        return label
    }()

    
    var bookMarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(named: "TextBlue")
        button.setImage(UIImage(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17)), for: .normal)
        return button
    }()
    
    let quizLabel: UITextView = {
        let textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        textview.textColor = UIColor(named: "PrimaryBlack")
        textview.textContainerInset  = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        textview.text = "감찰관은 소속 경찰기관의 관할구역 안에서 활동하는 것을 원칙으로 한다. 다만, 필요한 경우에는 관할구역 밖에서도 활동할 수 있다."
        textview.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        return textview
    }()
    
    let buttonStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 16
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
        return stackview
    }()
    
    var correctButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 54, weight: .bold)
        let image = UIImage(systemName: "circle", withConfiguration: imageConfig)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 14
        button.backgroundColor = UIColor(named: "GraysGray 5")
        return button
    }()
    
    var wrongButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 54, weight: .bold)
        let image = UIImage(systemName: "xmark", withConfiguration: imageConfig)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 14
        button.backgroundColor = UIColor(named: "GraysGray 5")
        return button
    }()
    
//    let correctImageView: UIImageView = {
//        let imageview = UIImageView()
//        imageview.image = UIImage(named: "OImage")
//
//        imageview.contentMode = .scaleToFill
//        return imageview
//    }()
//
//    let wrongImageView: UIImageView = {
//        let imageview = UIImageView()
//        imageview.image = UIImage(named: "XImage")
//        imageview.contentMode = .scaleToFill
//        return imageview
//    }()
//
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    private func setup() {
        
        view.addSubview(chapterStackView)
        view.addSubview(progressStackView)
        view.addSubview(contentStackView)
        view.addSubview(quizBackgroundView)
        view.addSubview(quizTitleStackview)
        view.addSubview(quizLabel)
        view.addSubview(buttonStackView)
//        view.addSubview(wrongImageView)
//        view.addSubview(correctImageView)
        
        
        chapterStackView.addArrangedSubview(chapterNumberLabel)
        chapterStackView.addArrangedSubview(chapterTitleLabel)
        
        progressStackView.addArrangedSubview(progressView)
        progressStackView.addArrangedSubview(progressNumberLabel)
        progressStackView.addArrangedSubview(badgeImageView)
        
        quizTitleStackview.addArrangedSubview(quizNumberLabel)
        quizTitleStackview.addArrangedSubview(bookMarkButton)

        buttonStackView.addArrangedSubview(correctButton)
        buttonStackView.addArrangedSubview(wrongButton)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            chapterStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            chapterStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            progressView.centerYAnchor.constraint(equalTo: progressStackView.centerYAnchor),
            progressView.leadingAnchor.constraint(equalTo: progressStackView.leadingAnchor, constant: 0),
            progressView.trailingAnchor.constraint(equalTo: progressStackView.trailingAnchor, constant: -88),
            
            progressNumberLabel.leadingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: 10),
            progressNumberLabel.trailingAnchor.constraint(equalTo: progressStackView.trailingAnchor, constant: -38),
            progressNumberLabel.centerYAnchor.constraint(equalTo: progressStackView.centerYAnchor),
            
            badgeImageView.centerYAnchor.constraint(equalTo: progressStackView.centerYAnchor),
            badgeImageView.leadingAnchor.constraint(equalTo: progressNumberLabel.trailingAnchor, constant: 10),
            badgeImageView.trailingAnchor.constraint(equalTo: progressStackView.trailingAnchor, constant: 0),
            
            progressStackView.topAnchor.constraint(equalTo: chapterStackView.bottomAnchor, constant: 16),
            progressStackView.heightAnchor.constraint(equalToConstant: 28),
            progressStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            progressStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            contentStackView.topAnchor.constraint(equalTo: progressStackView.bottomAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -206),
            
            quizBackgroundView.topAnchor.constraint(equalTo: contentStackView.topAnchor, constant: 16),
            quizBackgroundView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
            quizBackgroundView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
            quizBackgroundView.heightAnchor.constraint(equalToConstant: 40),
            
            quizTitleStackview.topAnchor.constraint(equalTo: quizBackgroundView.topAnchor, constant: 9),
            quizTitleStackview.leadingAnchor.constraint(equalTo: quizBackgroundView.leadingAnchor, constant: 10),
            quizTitleStackview.bottomAnchor.constraint(equalTo: quizBackgroundView.bottomAnchor, constant: -9),
            quizTitleStackview.trailingAnchor.constraint(equalTo: quizBackgroundView.trailingAnchor, constant: -10),
            
            quizLabel.topAnchor.constraint(equalTo: quizBackgroundView.bottomAnchor, constant: 16),
            quizLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 26),
            quizLabel.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -26),
            quizLabel.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: -26),
            
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -21),
            buttonStackView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 55),
            
        ])
    }
}

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
        return label
    }()
    
    let chpaterTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(named: "PrimaryBlack")
        label.text = "경찰 개념의 연혁"
        return label
    }()
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.trackTintColor = .white
        view.progressTintColor = UIColor(named: "BarPoint")
        view.progress = 0.1
        return view
    }()
    
    let progressNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "0 / 30"
        return label
    }()
    
    let badgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let quizNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor(named: "PrimaryBlack")
        label.text = "Quiz 1"
        return label
    }()
    
    var bookMarkBautton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(named: "TextBlue")
        return button
    }()
    
    let quizLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor(named: "PrimaryBlack")
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.text = "감찰관은 소속 경찰기관의 관할구역 안에서 활동하는 것을 원칙으로 한다."
        return label
    }()
    
    var correctBautton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.gray
        return button
    }()
    
    var wrongBautton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.gray
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setup() {
        
    }
    
    private func layout() {
        
    }
}

//
//  QuizView.swift
//  ARTX-PoliceScience
//
//  Created by yusang on 10/11/23.
//

import UIKit

class TitleView: UIView {
    
    private let chapterNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let text = "CHAPTER 01"
        label.text = text
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(resource: .textBlue)
        
        return label
    }()
    
    private let chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let text = "경찰 개념의 연혁"
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(resource: .primaryBlack)
        
        return label
    }()
    
    private lazy var chapterStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            chapterNumberLabel,
            chapterTitleLabel
        ])
        view.axis = .vertical
        view.spacing = 4
        view.alignment = .center
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(chapterStackView)
        chapterStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chapterNumberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            chapterNumberLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 124),
            chapterTitleLabel.topAnchor.constraint(equalTo: chapterNumberLabel.bottomAnchor, constant: 26),
            chapterTitleLabel.centerXAnchor.constraint(equalTo: chapterNumberLabel.centerXAnchor),
            chapterStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

class ProgressView: UIView {
    
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.trackTintColor = .white
        view.progressTintColor = UIColor(resource: .barPoint)
        view.transform = CGAffineTransformScale(view.transform, 1, 0.2)
        view.progress = 0.0
        view.setProgress(0.3, animated: true)
        return view
    }()
    
    private let progressNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        var text = "0"
        text += " /"
        label.text = text
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        //assets에 alpha값 고려한거 추가하면 고칠게요...
        label.textColor = UIColor(hex: "#000000", alpha: 0.6)
        return label
    }()
    
    private let progressTotalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "30"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        //assets에 alpha값 고려한거 추가하면 고칠게요...
        label.textColor = UIColor(hex: "#000000", alpha: 0.6)
        return label
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "heart.fill"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var progressStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            progressView,
            progressNumberLabel,
            progressTotalLabel,
            imageView
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 10
        view.alignment = .center
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(progressStackView)
        
        progressStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            //            progressView.centerYAnchor.constraint(equalTo: progressStackView.centerYAnchor),
            //            progressView.leadingAnchor.constraint(equalTo: progressStackView.leadingAnchor, constant: 0),
            //            progressView.trailingAnchor.constraint(equalTo: progressStackView.trailingAnchor, constant: -88),
            //
            //            progressNumberLabel.leadingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: 10),
            //            progressNumberLabel.trailingAnchor.constraint(equalTo: progressStackView.trailingAnchor, constant: -38),
            //            progressNumberLabel.centerYAnchor.constraint(equalTo: progressStackView.centerYAnchor),
            //
            //            imageView.centerYAnchor.constraint(equalTo: progressStackView.centerYAnchor),
            //            imageView.leadingAnchor.constraint(equalTo: progressNumberLabel.trailingAnchor, constant: 10),
            //            imageView.trailingAnchor.constraint(equalTo: progressStackView.trailingAnchor, constant: 0),
            
            progressStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 183),
            progressStackView.heightAnchor.constraint(equalToConstant: 28),
            progressStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            progressStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
        
    }
    
}

class QuizView: UIView {
    
    private lazy var contentStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            quizBackgroundView,
            quizTitleStackview,
            quizLabel
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 14
        view.backgroundColor = .white
        
        //경계 넘어가지 못하게 막을려고
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    private let quizBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(resource: .bgGroupedPrimary)
        return view
    }()
    
    private lazy var quizTitleStackview: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            quizNumberLabel,
            bookMarkButton
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 207
        return view
    }()
    
    private let quizNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quiz 5"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor(resource: .primaryBlack)
        return label
    }()
    
    private lazy var bookMarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(resource: .textBlue)
        button.setImage(UIImage(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17)), for: .normal)
        button.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside )
        return button
    }()
    
    @objc func myButtonTapped() {
        if bookMarkButton.isSelected == true {
            bookMarkButton.isSelected = false
        }
        else {
            bookMarkButton.isSelected = true
        }
    }
    
    // 원래는 uilabel로 글자수랑 줄 정할려고 했음
    //    private let quizLabel: UILabel = {
    //        let label = UILabel()
    //        label.text = "감찰관은 소속 경찰기관의 관할구역 안에서 활동하는 것을 원칙으로 한다. 다만, 필요한 경우에는 관할구역 밖에서도 활동할 수 있다"
    //
    //        //글자 수 제한 무제한
    //        label.numberOfLines = 0
    //        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width / 2 - 15
    //
    //        return label
    //    }()
    
    private let quizLabel: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        view.textColor = UIColor(named: "PrimaryBlack")
        view.textContainerInset  = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        view.text = "감찰관은 소속 경찰기관의 관할구역 안에서 활동하는 것을 원칙으로 한다. 다만, 필요한 경우에는 관할구역 밖에서도 활동할 수 있다"
        view.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 227),
            contentStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
            
//            contentStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            contentStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            contentStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -206),
//            
//            quizBackgroundView.topAnchor.constraint(equalTo: contentStackView.topAnchor, constant: 16),
//            quizBackgroundView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
//            quizBackgroundView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
//            quizBackgroundView.heightAnchor.constraint(equalToConstant: 40),
//            
//            quizTitleStackview.topAnchor.constraint(equalTo: quizBackgroundView.topAnchor, constant: 9),
//            quizTitleStackview.leadingAnchor.constraint(equalTo: quizBackgroundView.leadingAnchor, constant: 10),
//            quizTitleStackview.bottomAnchor.constraint(equalTo: quizBackgroundView.bottomAnchor, constant: -9),
//            quizTitleStackview.trailingAnchor.constraint(equalTo: quizBackgroundView.trailingAnchor, constant: -10),
//            
//            quizLabel.topAnchor.constraint(equalTo: quizBackgroundView.bottomAnchor, constant: 16),
//            quizLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 26),
//            quizLabel.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -26),
//            quizLabel.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: -26),
//            
        ])
        
        
        
        
    }
}

class OXbuttonView:UIView {
    
    private lazy var buttonStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [
            correctButton,
            wrongButton
        ])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 16
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
        return stackview
    }()
    
    private lazy var correctButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 54, weight: .bold)
        let image = UIImage(systemName: "circle", withConfiguration: imageConfig)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 14
        button.backgroundColor = UIColor(resource: .pointGray)
        button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside )
        
        return button
    }()
    
    private lazy var wrongButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 54, weight: .bold)
        let image = UIImage(systemName: "xmark", withConfiguration: imageConfig)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 14
        button.backgroundColor = UIColor(resource: .pointGray)
        button.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside )
        
        return button
    }()
    
    @objc func rightButtonTapped() {
        //alpha값 세팅된거 나오면 고칠 예정...
        correctButton.backgroundColor = UIColor(hex: "#007AFF", alpha: 0.7)
    }
    
    @objc func myButtonTapped() {
        //alpha값 세팅된거 나오면 고칠 예정...
        wrongButton.backgroundColor = UIColor(hex: "#FF3B30", alpha: 0.7)
    }
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 672),
            buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        ])
        
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

//
//  QuizView.swift
//  ARTX-PoliceScience
//
//  Created by yusang on 10/11/23.
//

import UIKit

class TitleView: UIView {
    
    let chapterNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let text = "CHAPTER 01"
        label.text = text
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(resource: .textBlue)
        
        return label
    }()
    
    let chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let text = "경찰 개념의 연혁"
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(resource: .primaryBlack)
        
        return label
    }()
    
    lazy var chapterStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 4
        view.alignment = .center
        
        return view
    }()
}

class ProgressbarView: UIView {
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.trackTintColor = .white
        view.progressTintColor = UIColor(resource: .barPoint)
        view.transform = CGAffineTransformScale(view.transform, 1, 0.2)
        view.progress = 0.0
        view.setProgress(0.3, animated: true)
        return view
    }()

    let progressNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " 0/30"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        //assets에 alpha값 고려한거 추가하면 고칠게요...
        label.textColor = UIColor(hex: "#000000", alpha: 0.6)
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "heart.fill"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var progressStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 10
        view.alignment = .center
        return view
    }()
    
}

class QuizView: UIView {
    
    let quizBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 14
        return view
    }()
    
    lazy var quizTitlBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(resource: .bgGroupedPrimary)
        return view
    }()
    
    let quizNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quiz 5"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor(resource: .primaryBlack)
        return label
    }()
    
    lazy var bookMarkButton: UIButton = {
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
    
    let quizLabel: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        view.textColor = UIColor(named: "PrimaryBlack")
        view.textContainerInset  = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        view.text = "감찰관은 소속 경찰기관의 관할구역 안에서 활동하는 것을 원칙으로 한다. 다만, 필요한 경우에는 관할구역 밖에서도 활동할 수 있다"
        view.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        return view
    }()
}

class OXbuttonView:UIView {
    
    lazy var buttonStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 16
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
        return stackview
    }()
    
    lazy var correctButton: UIButton = {
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
    
    lazy var wrongButton: UIButton = {
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

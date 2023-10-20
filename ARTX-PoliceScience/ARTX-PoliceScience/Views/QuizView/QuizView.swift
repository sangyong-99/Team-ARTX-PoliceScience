//
//  QuizView.swift
//  ARTX-PoliceScience
//
//  Created by yusang on 10/11/23.
//
import UIKit

class QuizView: UIView {
    let quizBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 14
        
        view.layer.shadowColor = UIColor(red: 0.102, green: 0.176, blue: 0.561, alpha: 0.1).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()
    
    lazy var quizTitlBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(resource: .bgPrimary)
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
    
    lazy var bookMarkButton: ExtendedTouchButton = {
        let button = ExtendedTouchButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(resource: .textBlue)
        button.setImage(UIImage(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)), for: .normal)
        button.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside )
        
        return button
    }()
    
    var addBookmark: ((Bool) -> Void)?
    
    @objc func myButtonTapped() {
        if bookMarkButton.isSelected == true {
            bookMarkButton.setImage(UIImage(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)), for: .normal)
            bookMarkButton.isSelected = false
            addBookmark?(false)
            CustomHaptics.shared.bookMarkTapped()
        }
        else {
            bookMarkButton.setImage(UIImage(systemName: "bookmark.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)), for: .normal)
            bookMarkButton.isSelected = true
            addBookmark?(true)
            CustomHaptics.shared.bookMarkTapped()
        }
    }
    
    let quizLabel: UITextView = {
        let label = UITextView()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 6
        let attributes = [NSAttributedString.Key.paragraphStyle: style, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)]
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "감찰관은 소속 경찰기관의 관할구역 안에서 활동하는 것을 원칙으로 한다. 다만, 필요한 경우에는 관할구역 밖에서도 활동할 수 있다"
//        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor(resource: .primaryBlack)
        label.typingAttributes = attributes
        //글자 수 제한 무제한
        label.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        label.isEditable = false
        return label
    }()
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

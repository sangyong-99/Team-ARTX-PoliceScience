//
//  QuizView.swift
//  ARTX-PoliceScience
//
//  Created by yusang on 10/11/23.
//
import UIKit

class QuizView: UIView {
    
    var quizNumber: Int = 0 {
        didSet {
            updatequizNumberLabel()
        }
    }
    
    var quiz: String = "" {
        didSet {
            updatequizLabel()
        }
    }
    
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
        let quizNumber = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quiz \(quizNumber)"
        label.font = UIFont.headLine
        label.textColor = UIColor(resource: .primaryBlack)
        return label
    }()
    
    lazy var bookMarkButton: ExtendedTouchButton = {
        let button = ExtendedTouchButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(resource: .textBlue)
        button.setImage(UIImage(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.bodyBold)), for: .normal)
//        button.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside )
        
        return button
    }()
    
    var addBookmark: ((Bool) -> Void)?
    
    @objc func myButtonTapped() {
        if bookMarkButton.isSelected == true {
            bookMarkButton.setImage(UIImage(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.bodyBold)), for: .normal)
            bookMarkButton.isSelected = false
//            addBookmark?(false)
            CustomHaptics.shared.bookMarkTapped()
        }
        else {
            bookMarkButton.setImage(UIImage(systemName: "bookmark.fill", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.bodyBold)), for: .normal)
            bookMarkButton.isSelected = true
//            addBookmark?(true)
            CustomHaptics.shared.bookMarkTapped()
        }
    }
    
    let quizLabel: UITextView = {
        let label = UITextView()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 6
        let attributes = [NSAttributedString.Key.paragraphStyle: style, NSAttributedString.Key.font: UIFont.quizText]
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(resource: .primaryBlack)
        label.typingAttributes = attributes
        //글자 수 제한 무제한
        label.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        label.isEditable = false
        return label
    }()
    
    private func updatequizNumberLabel() {
        let text = "Quiz \(quizNumber + 1)"
        quizNumberLabel.text = text
    }
    
    private func updatequizLabel() {
        let text = quiz
        quizLabel.text = text
    }
}

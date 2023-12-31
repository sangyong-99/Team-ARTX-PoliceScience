//
//  QuizModalView.swift
//  ARTX-PoliceScience
//
//  Created by Harry on 10/14/23.
//

import UIKit

class QuizModalView: UIView {
    var addBookmark: ((Bool) -> Void)?
    
    let labelBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // 여기 나중에 바꿔주세요 -> 에셋값으로
        view.backgroundColor = UIColor(resource: .bgPrimary)
        return view
    }()
    
    let correctNotificationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "맞았습니다."
        label.font = .headLineBoldKR
        label.textColor = UIColor(resource: .textBlue)
        return label
    }()
    
    let correctLabel: UILabel = {
        let label = UILabel()
        let font = UIFont.title2BoldKR
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "정답: X", attributes: [.font: UIFont.title2BoldKR, .foregroundColor: UIColor(resource: .primaryBlack)])
        return label
    }()
    
    let explanationLabel: UITextView = {
        let textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.text = "감찰관은 관할구역 안에서 활동하는 것이 원칙이지만, 필요한 경우에는 밖에서도 활등이 가능합니다.감찰관은 관할구역 안에서 활동하는 것이 원칙이지만, 필요한 경우에는 밖에서도 활등이 가능합니다.감찰관은 관할구역 안에서 활동하는 것이 원칙이지만, 필요한 경우에는 밖에서도 활등이 가능합니다.감찰관은 관할구역 안에서 활동하는 것이 원칙이지만, 필요한 경우에는 밖에서도 활등이 가능합니다."
        textview.textColor = UIColor(resource: .primaryBlack)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        let attributes = [NSAttributedString.Key.paragraphStyle: style, NSAttributedString.Key.font: UIFont.callOutKR]
        textview.typingAttributes = attributes
        textview.isEditable = false
        textview.textContainer.lineFragmentPadding = 0
        textview.showsVerticalScrollIndicator = false
        textview.font = .callOutKR
        return textview
    }()
    
    lazy var nextQuestionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor(resource: .bgBlue)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        return button
    }()
    
}

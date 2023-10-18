//
//  QuizModalView.swift
//  ARTX-PoliceScience
//
//  Created by Harry on 10/14/23.
//

import UIKit

class QuizModalView: UIView {
    
    let labelBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // 여기 나중에 바꿔주세요 -> 에셋값으로
        view.backgroundColor = UIColor(hex: "007AFF").withAlphaComponent(0.26)
        return view
    }()
    
    let correctNotificationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "맞았습니다."
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor(resource: .textBlue)
        return label
    }()
    
    lazy var bookMarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(resource: .textBlue)
        button.setImage(UIImage(systemName: "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 17)), for: .normal)
        button.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside )
        return button
    }()
    
    let correctLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "정답: X"
        label.textColor = UIColor(resource: .primaryBlack)
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    let explanationLabel: UITextView = {
        let textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.text = "감찰관은 관할구역 안에서 활동하는 것이 원칙이지만, 필요한 경우에는 밖에서도 활등이 가능합니다.감찰관은 관할구역 안에서 활동하는 것이 원칙이지만, 필요한 경우에는 밖에서도 활등이 가능합니다.감찰관은 관할구역 안에서 활동하는 것이 원칙이지만, 필요한 경우에는 밖에서도 활등이 가능합니다.감찰관은 관할구역 안에서 활동하는 것이 원칙이지만, 필요한 경우에는 밖에서도 활등이 가능합니다."
        textview.textColor = UIColor(resource: .primaryBlack)
        textview.isEditable = false
        textview.textContainer.lineFragmentPadding = 0
        textview.showsVerticalScrollIndicator = false
        textview.font = .systemFont(ofSize: 16, weight: .regular)
        return textview
    }()
    
    lazy var nextQuestionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor(resource: .bgBlue)
        button.setTitle("다음 문제", for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(nextQuestionButtonTapped), for: .touchUpInside )
        return button
    }()
    
    @objc func bookmarkButtonTapped() {
        
    }
    
    @objc func nextQuestionButtonTapped() {
        
    }
    
}

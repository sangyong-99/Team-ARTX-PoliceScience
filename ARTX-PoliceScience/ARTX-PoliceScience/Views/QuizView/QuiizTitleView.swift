//
//  QuiizTitle.swift
//  ARTX-PoliceScience
//
//  Created by yusang on 10/14/23.
//

import Foundation
import UIKit

class QuizTitleView: UIView {
    
    let chapterNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let text = "CHAPTER 01"
        label.text = text
        label.font = UIFont.caption1Bold
        label.textColor = UIColor(resource: .textBlue)
        
        return label
    }()
    
    let chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let text = "경찰 개념의 연혁"
        label.text = text
        label.font = UIFont.title3BoldKR
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

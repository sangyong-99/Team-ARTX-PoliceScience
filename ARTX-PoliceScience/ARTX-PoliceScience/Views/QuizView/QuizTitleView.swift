//
//  QuizTitle.swift
//  ARTX-PoliceScience
//
//  Created by yusang on 10/14/23.
//

import Foundation
import UIKit

class QuizTitleView: UIView {
    
    var chapterNumber: Int = 0 {
        didSet {
            updateChapterNumberLabel()
        }
    }
    
    var chapterName: String = "" {
        didSet {
            updateChapterName()
        }
    }
    
    let chapterNumberLabel: UILabel = {
        let label = UILabel()
        let chapterNumber = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.caption1Bold
        label.textColor = UIColor(resource: .textBlue)
        
        return label
    }()
    
    let chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    private func updateChapterNumberLabel() {
        let text = "CHAPTER \(chapterNumber)"
        chapterNumberLabel.text = text
    }
    
    private func updateChapterName() {
        let text = "\(chapterName)"
        chapterTitleLabel.text = text
    }
}

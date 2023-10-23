//
//  Books.swift
//  ARTX-PoliceScience
//
//  Created by Harry on 2023/10/08.
//

import UIKit

enum BookType {
    case policeStudiesBasic
    case policeStudiesPastExam
}

extension BookType {
    var bookimage: UIImage {
        switch self {
        case .policeStudiesBasic:
            return UIImage(named: "policeStudiesBasicImage")!
        case .policeStudiesPastExam:
            return UIImage(named: "policeStudiesPastExamImage")!
        }
    }
    
    var bookname: String {
        switch self {
        case .policeStudiesBasic:
            return "2024 해커스 조현 경찰학 기본서"
        case .policeStudiesPastExam:
            return "2024 해커스 조현 경찰학 기출문제집"
        }
    }
}

enum Symbol {
    case purchaseButton
}

extension Symbol {
    var image: UIImage? {
        switch self {
        case .purchaseButton:
            return UIImage(systemName: "cart.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 35))!
        }
    }
}

enum NavigationTitle {
    case bookView
    case bookmarkView
}

extension NavigationTitle {
    var title: String {
        switch self {
        case .bookView:
            return "애플 아카데미 OX 퀴즈란?"
        case .bookmarkView:
            return "북마크"
        }
    }
}


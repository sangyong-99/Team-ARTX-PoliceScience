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

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


extension UIColor {
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}


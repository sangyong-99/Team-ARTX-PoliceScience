//
//  FontStyle.swift
//  ARTX-PoliceScience
//
//  Created by apple on 10/12/23.
//

import UIKit

enum FontSize {
    static let largeTitle: CGFloat = 34
    static let title1: CGFloat = 28
    static let title2: CGFloat = 22
    static let title3: CGFloat = 20
    static let headLine: CGFloat = 17
    static let body: CGFloat = 17
    static let callOut: CGFloat = 16
    static let subHead: CGFloat = 15
    static let footNote: CGFloat = 13
    static let caption1: CGFloat = 12
    static let caption2: CGFloat = 11
    
    static let partText: CGFloat = 12
    static let quizText: CGFloat = 18
    
    static let mainTitle: CGFloat = 34
}

extension UIFont {
    /// FontStyle을 적용하기 위한 extention
    /// ex.
    /// var textLabel: UILabel = {
    ///     var label = UILabel()
    ///     label.font = .largeTitle
    ///     return label
    /// }()
    static let largeTitle = UIFont.systemFont(ofSize: FontSize.largeTitle, weight: .regular)
    static let largeTitleBold = UIFont.systemFont(ofSize: FontSize.largeTitle, weight: .bold)
    
    static let title1 = UIFont.systemFont(ofSize: FontSize.title1, weight: .regular)
    static let title1Bold = UIFont.systemFont(ofSize: FontSize.title1, weight: .bold)
    
    static let title2 = UIFont.systemFont(ofSize: FontSize.title2, weight: .regular)
    static let title2Bold = UIFont.systemFont(ofSize: FontSize.title2, weight: .bold)
    static let title2BoldKR = UIFont.systemFont(ofSize: FontSize.title2, weight: .bold)
    
    static let title3 = UIFont.systemFont(ofSize: FontSize.title3, weight: .regular)
    static let title3Bold = UIFont.systemFont(ofSize: FontSize.title3, weight: .semibold)
    static let title3BoldKR = UIFont.systemFont(ofSize: FontSize.title3, weight: .bold)
    
    static let headLine = UIFont.systemFont(ofSize: FontSize.headLine, weight: .semibold)
    static let headLineBoldKR = UIFont.systemFont(ofSize: FontSize.headLine, weight: .bold)
    
    static let body = UIFont.systemFont(ofSize: FontSize.body, weight: .regular)
    static let bodyBold = UIFont.systemFont(ofSize: FontSize.body, weight: .bold)
    static let bodyKR = UIFont.systemFont(ofSize: FontSize.body, weight: .regular)
    
    static let callOut = UIFont.systemFont(ofSize: FontSize.callOut, weight: .regular)
    static let callOutBold = UIFont.systemFont(ofSize: FontSize.callOut, weight: .semibold)
    static let callOutKR = UIFont.systemFont(ofSize: FontSize.callOut, weight: .regular)
    static let callOutBoldKR = UIFont.systemFont(ofSize: FontSize.callOut, weight: .bold)
    
    static let subHead = UIFont.systemFont(ofSize: FontSize.subHead, weight: .regular)
    static let subHeadBold = UIFont.systemFont(ofSize: FontSize.subHead, weight: .semibold)
    static let subHeadKR = UIFont.systemFont(ofSize: FontSize.subHead, weight: .regular)
    static let subHeadBoldKR = UIFont.systemFont(ofSize: FontSize.subHead, weight: .bold)
    
    static let footNote = UIFont.systemFont(ofSize: FontSize.footNote, weight: .regular)
    static let footNoteBold = UIFont.systemFont(ofSize: FontSize.footNote, weight: .semibold)
    static let footNoteBoldKR = UIFont.systemFont(ofSize: FontSize.footNote, weight: .regular)
    
    static let caption1 = UIFont.systemFont(ofSize: FontSize.caption1, weight: .regular)
    static let caption1Bold = UIFont.systemFont(ofSize: FontSize.caption1, weight: .medium)
    static let caption1KR = UIFont.systemFont(ofSize: FontSize.caption1, weight: .regular)
    static let caption1BoldKR = UIFont.systemFont(ofSize: FontSize.caption1, weight: .semibold)
    
    static let caption2 = UIFont.systemFont(ofSize: FontSize.caption2, weight: .regular)
    static let caption2Bold = UIFont.systemFont(ofSize: FontSize.caption2, weight: .semibold)
    
    static let partText = UIFont.systemFont(ofSize: FontSize.partText, weight: .heavy)
    static let quizText = UIFont.systemFont(ofSize: FontSize.quizText, weight: .medium)
    
    static let gmarketBold = UIFont(name: "GmarketSansTTFBold", size: FontSize.mainTitle)
    static let gmarketMedium = UIFont(name: "GmarketSansTTFMedium", size: FontSize.mainTitle)
}

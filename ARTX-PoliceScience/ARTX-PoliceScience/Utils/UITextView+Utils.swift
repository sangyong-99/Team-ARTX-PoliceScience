//
// UITextView+Utils.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/18/23.
//

import UIKit

extension UITextView {
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
}

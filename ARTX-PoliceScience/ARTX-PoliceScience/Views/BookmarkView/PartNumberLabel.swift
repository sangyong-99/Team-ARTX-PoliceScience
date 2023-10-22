//
//  PartNumberLabel.swift
//  ARTX-PoliceScience
//
//  Created by apple on 10/13/23.
//

import UIKit

class PartNumberLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureLabel() {
        self.textAlignment = .left
        self.font = .partText
        self.textColor = .pointText
        
        let attributedString = NSMutableAttributedString.init(string: "Apply UnderLining")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
    
    func updateText(to number: Int) {
        self.text = "PART \(number)"
    }
}

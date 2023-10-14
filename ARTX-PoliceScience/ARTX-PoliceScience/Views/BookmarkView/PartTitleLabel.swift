//
//  PartTitleLabel.swift
//  ARTX-PoliceScience
//
//  Created by apple on 10/13/23.
//

import UIKit

class PartTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureLabel() {
        self.textAlignment = .left
        self.font = .title3Bold
        self.textColor = .black
    }
    
    func updateText(to title: String) {
        self.text = title
    }
}

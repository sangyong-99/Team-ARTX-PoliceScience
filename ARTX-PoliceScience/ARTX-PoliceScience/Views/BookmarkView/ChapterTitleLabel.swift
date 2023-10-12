//
//  ChapterTitleLabel.swift
//  ARTX-PoliceScience
//
//  Created by apple on 10/12/23.
//

import UIKit

class ChapterTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureLabel() {
        self.textAlignment = .left
        self.font = .subHeadBold
        self.textColor = .black
    }
    
    func updateText(to title: String) {
        self.text = title
    }
}

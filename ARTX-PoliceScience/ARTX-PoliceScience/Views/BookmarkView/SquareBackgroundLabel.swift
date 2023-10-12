//
//  SquareBackgroundLabel.swift
//  ARTX-PoliceScience
//
//  Created by apple on 10/12/23.
//

import UIKit

class SquareBackgroundLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureLabel() {
        self.textAlignment = .left
        self.font = .caption1
        self.textColor = .pointRed
        self.clipsToBounds = true
        self.layer.cornerRadius = 2
        self.backgroundColor = .markRed
    }
    
    func updateText(to quizeCount: Int) {
        self.text = "\(quizeCount)"
    }
}

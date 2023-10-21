//
//  UIButton+Util.swift
//  ARTX-PoliceScience
//
//  Created by Jae Ho Yoon on 10/20/23.
//

import UIKit

class ExtendedTouchButton: UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let newArea = CGRect(
            x: self.bounds.origin.x - 10.0,
            y: self.bounds.origin.y - 10.0,
            width: self.bounds.size.width + 20.0,
            height:self.bounds.size.height + 20.0
        )
        return newArea.contains(point)
    }
}

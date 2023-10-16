//
//  Half.swift
//  ARTX-PoliceScience
//
//  Created by yusang on 10/14/23.
//

import UIKit

class HalfModalPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            return CGRect.zero
        }
        return CGRect(x: 0, y: containerView.bounds.height - 291, width: containerView.bounds.width, height: 291)
    }
}

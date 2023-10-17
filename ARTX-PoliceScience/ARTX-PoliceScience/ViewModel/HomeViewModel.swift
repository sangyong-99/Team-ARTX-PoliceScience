//
//  HomeViewModel.swift
//  ARTX-PoliceScience
//
//  Created by Jae Ho Yoon on 10/9/23.
//

import UIKit

class HomeViewModel {
    static func selectProgressImages(progress: Float) -> UIImage {
        switch progress {
        case ..<0.333:
            return UIImage.gradeBadge0
        case ..<0.666:
            return UIImage.gradeBadge1
        default:
            return UIImage.gradeBadge2
        }
    }
    
}

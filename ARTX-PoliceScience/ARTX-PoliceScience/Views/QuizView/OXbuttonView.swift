//
//  OXbuttonView.swift
//  ARTX-PoliceScience
//
//  Created by yusang on 10/14/23.
//

import Foundation
import UIKit

class OXbuttonView:UIView {
    
    lazy var buttonStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 16
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
        return stackview
    }()
    
    lazy var correctButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(resource: .buttonTrue)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black20.cgColor
        button.backgroundColor = .pointGray
        
        button.layer.shadowColor = UIColor(red: 0.102, green: 0.176, blue: 0.561, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 0, height: 4)

        //button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside )
        
        return button
    }()
    
    lazy var wrongButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(resource: .buttonFalse)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 14
        button.backgroundColor = .pointGray
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black20.cgColor
        
        button.layer.shadowColor = UIColor(red: 0.102, green: 0.176, blue: 0.561, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        button.adjustsImageWhenHighlighted = false
        //button.addTarget(self, action: #selector(wrongButtonTapped), for: .touchUpInside )
        
        return button
    }()
    
}

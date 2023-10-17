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
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 54, weight: .bold)
        let image = UIImage(systemName: "circle", withConfiguration: imageConfig)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 14
        button.backgroundColor = UIColor(resource: .pointGray)
        button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside )
        
        return button
    }()
    
    lazy var wrongButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 54, weight: .bold)
        let image = UIImage(systemName: "xmark", withConfiguration: imageConfig)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 14
        button.backgroundColor = UIColor(resource: .pointGray)
        button.addTarget(self, action: #selector(wrongButtonTapped), for: .touchUpInside )
        
        return button
    }()
    
    @objc func rightButtonTapped() {
        //alpha값 세팅된거 나오면 고칠 예정...
        correctButton.backgroundColor = UIColor(hex: "#007AFF", alpha: 0.7)
    }
    
    @objc func wrongButtonTapped() {
        //alpha값 세팅된거 나오면 고칠 예정...
        wrongButton.backgroundColor = UIColor(hex: "#FF3B30", alpha: 0.7)
    }
    
}

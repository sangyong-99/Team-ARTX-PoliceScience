//
//  QuizProgressView.swift
//  ARTX-PoliceScience
//
//  Created by yusang on 10/14/23.
//

import Foundation
import UIKit

class QuizProgressView: UIView {

    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.trackTintColor = .white
        view.progressTintColor = UIColor(resource: .barPoint)
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.progress = 0.0
        view.setProgress(0.0, animated: true)
        return view
    }()

    let progressNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " 0/30"
        label.textAlignment = .right
        label.font = UIFont.caption1
        label.textColor = .black60
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView(image: UIImage.iconCompletionTrue)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var progressStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 10
        view.alignment = .center
        return view
    }()
    
}

//
//  HomeTableHeaderView.swift
//  ARTX-PoliceScience
//
//  Created by Jae Ho Yoon on 10/11/23.
//

import UIKit

class HomeTableHeaderView: UIView {
    
    static let height: CGFloat = 370
    
    private let bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .homeBG)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let progressView: UIView = {
        let progress = UIView()
        progress.backgroundColor = .white
        progress.layer.cornerRadius = 14
        progress.translatesAutoresizingMaskIntoConstraints = false
        
        progress.layer.shadowColor = UIColor(red: 0.102, green: 0.176, blue: 0.561, alpha: 0.1).cgColor
        progress.layer.shadowOpacity = 1
        progress.layer.shadowRadius = 8
        progress.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        return progress
    }()
    
    private let progressViewTitle: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "chart.bar.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: " 전체 학습 진행도"))
        label.attributedText = attributedString
        label.font = .preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(bgImage)
        self.addSubview(progressView)
        self.addSubview(progressViewTitle)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeTableHeaderView {
    private func layout() {
        NSLayoutConstraint.activate([
            bgImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            bgImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bgImage.heightAnchor.constraint(equalTo: self.heightAnchor),
            bgImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -185),
            
            progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            progressView.heightAnchor.constraint(equalToConstant: 142),
            progressView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            
            progressViewTitle.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 16),
            progressViewTitle.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 16)
        ])
    }
}

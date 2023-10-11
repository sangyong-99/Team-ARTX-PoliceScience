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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(bgImage)
        
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
            bgImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -185)
        ])
    }
}

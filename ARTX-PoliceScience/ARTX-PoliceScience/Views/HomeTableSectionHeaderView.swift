//
//  HomeTableSectionHeaderView.swift
//  ARTX-PoliceScience
//
//  Created by Jae Ho Yoon on 10/10/23.
//

import UIKit

class HomeTableSectionHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "HomeTableHeaderView"
    
    private let partNumber: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: " ")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        label.attributedText = attributedString
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        label.textColor = .textBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let partTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let partStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(partStackView)
        partStackView.addArrangedSubview(partNumber)
        partStackView.addArrangedSubview(partTitle)
        
        NSLayoutConstraint.activate([
            partStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            partStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with section: HomeTableSection) {
        partNumber.text = section.partNumber
        partTitle.text = section.partTitle
    }
}

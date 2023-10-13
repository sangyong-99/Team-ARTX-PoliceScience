//
//  HomeTableCellView.swift
//  ARTX-PoliceScience
//
//  Created by Jae Ho Yoon on 10/9/23.
//

import UIKit

class HomeTableCellView: UITableViewCell {
    
    static let identifier = "HomeTableCellView"
    static let rowHeight: CGFloat = 69
    
    private let completionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let chapterNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.textColor = .textBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chapterTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chapterStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let quizCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel // 컬러 체크
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(completionIcon)
        
        contentView.addSubview(chapterStackView)
        chapterStackView.addArrangedSubview(chapterNumber)
        chapterStackView.addArrangedSubview(chapterTitle)
        
        contentView.addSubview(quizCount)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 프레임 사이즈 체크
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        completionIcon.image = nil
        chapterNumber.text = nil
        chapterTitle.text = nil
        quizCount.text = nil
    }
    
    public func configure(with model: HomeTableCell) {
        completionIcon.image = model.completionIcon
        chapterNumber.text = model.chapterNumber
        chapterTitle.text = model.chapterTitle
        // 인증 여부에 따라 변경
        quizCount.text = model.quizCount
    }
}

extension HomeTableCellView {
    private func layout() {
        NSLayoutConstraint.activate([
            completionIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            completionIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            completionIcon.widthAnchor.constraint(equalToConstant: 28),
            completionIcon.heightAnchor.constraint(equalToConstant: 28),
            
            chapterStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chapterStackView.leadingAnchor.constraint(equalTo: completionIcon.trailingAnchor, constant: 10),
            chapterStackView.heightAnchor.constraint(equalToConstant: 37),
            
            quizCount.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            quizCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
            
        ])
    }
}

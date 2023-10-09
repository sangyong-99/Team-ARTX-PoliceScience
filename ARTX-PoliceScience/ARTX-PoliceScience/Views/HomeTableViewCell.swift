//
//  HomeTableViewCell.swift
//  ARTX-PoliceScience
//
//  Created by Jae Ho Yoon on 10/9/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"
    
    private let completionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let chapterNumber: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let chapterTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let quizCount: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel // 컬러 체크
        label.numberOfLines = 1
        return label
    }()
    
    private let navigationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .secondaryLabel // 컬러 체크
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(completionIcon)
        contentView.addSubview(chapterNumber)
        contentView.addSubview(chapterTitle)
        contentView.addSubview(quizCount)
        contentView.addSubview(navigationIcon)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
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
        quizCount.text = quizCountLabel(isCodeActivated: LocalState.isCodeActivated)
        navigationIcon.image = UIImage(systemName: "chevron.right")
    }

    
// MARK: - 몇 문제 풀었는지 확인
    private func quizCountLabel(isCodeActivated: Bool) -> String {
        guard isCodeActivated else { return "􀎠" }
            return "30 / 30"
    }
}

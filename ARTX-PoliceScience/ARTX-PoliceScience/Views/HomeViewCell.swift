//
//  MainViewCell.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/11/23.
//

import UIKit

class HomeViewCell: UITableViewCell {
    static let identifier = "HomeViewCell"
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let chapterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.caption2Bold
        label.textColor = .pointText
        return label
    }()
    
    private let chapterNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.subHeadBoldKR
        return label
    }()
    
    private let questionProgressCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.caption1
        label.textColor = .black60
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical // 수직 스택뷰
        stackView.alignment = .leading // 왼쪽 정렬
        stackView.spacing = 4 // 아래에 작은 간격을 두도록 설정
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(questionProgressCountLabel)
        
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.frame = CGRect(x: 16, y: contentView.frame.size.height/2-14, width: 28, height: 28)
        
        stackView.addArrangedSubview(chapterLabel)
        stackView.addArrangedSubview(chapterNameLabel)
        chapterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chapterNameLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width - 105.16),
        ])
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 54),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])
        
        questionProgressCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionProgressCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            questionProgressCountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    public func configure(with chapter: Chapter, partChapter: String, undisabled: Bool) {
        chapterNameLabel.text = chapter.chapter_name
        chapterLabel.text = "CHAPTER 0\(chapter.chapter)"
        
        // 풀은 갯수 추가
        let currentChapterSolveNum = UserDefaults.standard.integer(forKey: partChapter)
        if undisabled {
            questionProgressCountLabel.text = "\(currentChapterSolveNum) / \(chapter.questions.count)"
        } else {
            let attributedString = NSMutableAttributedString(string: "")
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "lock", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.caption1))?.withTintColor(.black60)
            attributedString.append(NSAttributedString(attachment: imageAttachment))
            questionProgressCountLabel.attributedText = attributedString
            
        }
        // iconImageView Setting 하는 곳
        if currentChapterSolveNum == chapter.questions.count {
            iconImageView.image = .iconCompletionTrue
        } else {
            iconImageView.image = .iconCompletionFalse
        }
    }
    
    
}

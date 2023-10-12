//
//  MainViewCell.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/11/23.
//

import UIKit

class MainViewCell: UITableViewCell {
    static let identifier = "MainViewCell"
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let chapterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.textColor = .textBlue
        return label
    }()
    
    private let chapterNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let questionProgressCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        chapterNameLabel.text = nil
        iconImageView.image = nil
        questionProgressCountLabel.text = nil
    }
    
    public func configure(with model: Chapter) {
        chapterNameLabel.text = model.chapter_name
        chapterLabel.text = "CHAPTER 0\(model.chapter)"
        iconImageView.image = UIImage(named: "MainQuestionDefault")
        // 풀은 갯수 추가
        questionProgressCountLabel.text = "0 / \(model.questions.count)"
        // iconImageView Setting 하는 곳
        
    }
    
    
}

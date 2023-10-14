//
//  BookmarkEmptyTableViewCell.swift
//  ARTX-PoliceScience
//
//  Created by apple on 10/14/23.
//

import UIKit

class BookmarkEmptyTableViewCell: UITableViewCell {
    static let identifier = "BookmarkEmptyTableViewCell"
    
    private let emptyText: UILabel = {
        let label = UILabel()
        label.font = .footNote
        label.textColor = .secondaryLabel
        label.text = "저장된 문제가 없습니다"
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureBookmarkEmptyTableViewCell()
        self.layoutBookmarkEmptyTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureBookmarkEmptyTableViewCell() {
        self.contentView.backgroundColor = .white
        [
            self.emptyText
        ].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    private func layoutBookmarkEmptyTableViewCell() {
        emptyText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyText.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            emptyText.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0)
        ])
    }

}

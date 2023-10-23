//
//  BookmarkTableViewCell.swift
//  ARTX-PoliceScience
//
//  Created by apple on 10/12/23.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {
    
    static let identifier = "BookmarkTableViewCell"
    
    private var chapterNumberLabel = ChapterNumberLabel()
    private var chapterTitleLabel = ChapterTitleLabel()
    private var bookmarkCountLabel = SquareBackgroundLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureBookmarkTableViewCell()
        self.layoutBookmarkTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func update(bookmarkViewModel: BookmarkViewModel) {
        self.chapterNumberLabel.updateText(to: bookmarkViewModel.chapterNumber())
        self.chapterTitleLabel.updateText(to: bookmarkViewModel.chapterTitle())
        self.bookmarkCountLabel.updateText(to: bookmarkViewModel.bookmarkQuizCount())
    }
    
    private func configureBookmarkTableViewCell() {
        self.contentView.backgroundColor = .clear
        [
            self.chapterNumberLabel,
            self.chapterTitleLabel,
            self.bookmarkCountLabel
        ].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    private func layoutBookmarkTableViewCell() {
        chapterNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        chapterTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        bookmarkCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chapterNumberLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            chapterNumberLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),

            chapterTitleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            chapterTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),

            bookmarkCountLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            bookmarkCountLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
        ])
    }
}

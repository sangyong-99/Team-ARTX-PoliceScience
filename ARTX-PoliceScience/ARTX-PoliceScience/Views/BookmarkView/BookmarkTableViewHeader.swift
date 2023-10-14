//
//  BookmarkTableViewHeader.swift
//  ARTX-PoliceScience
//
//  Created by apple on 10/13/23.
//

import UIKit

class BookmarkTableViewHeader: UITableViewHeaderFooterView {
    
    static let identifier = "BookmarkViewHeader"
    
    private var partNumberLabel = PartNumberLabel()
    private var partTitleLabel = PartTitleLabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.configureBookmarkViewHeader()
        self.layoutBookmarkViewHeader()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func update(bookmarkViewModel: BookmarkViewModel) {
        self.partNumberLabel.updateText(to: bookmarkViewModel.partNumber())
        self.partTitleLabel.updateText(to: bookmarkViewModel.partTitle())
    }
    
    private func configureBookmarkViewHeader() {
        self.contentView.backgroundColor = .clear
        [
            self.partNumberLabel,
            self.partTitleLabel,
        ].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    private func layoutBookmarkViewHeader() {
        partNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        partTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            partNumberLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 26),
            partNumberLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),

            partTitleLabel.topAnchor.constraint(equalTo: self.partNumberLabel.bottomAnchor, constant: 8),
            partTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0)
        ])
    }
}

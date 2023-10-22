//
//  RegisSettingTableViewCell.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/7/23.
//

import UIKit

class RegisSettingTableViewCell: UITableViewCell {

    static let identifier = "RegisSettingTableViewCell"
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .pointText
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let codeLabel: UILabel = {
        let codeLabel = UILabel()
        
        codeLabel.textColor = .secondaryLabel
        codeLabel.numberOfLines = 1
        return codeLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconImageView)
        contentView.addSubview(codeLabel)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = 24
        
        iconImageView.frame = CGRect(x: 16, y: contentView.frame.size.height/2-11, width: 24, height: 22)
        
        label.frame = CGRect(x: 28 + size,
                             y: 0,
                             width: contentView.frame.size.width-85-51,
                             height: contentView.frame.size.height)
        codeLabel.sizeToFit()
        codeLabel.frame = CGRect(x: contentView.frame.size.width - codeLabel.frame.size.width - 14, y: 0, width: codeLabel.frame.size.width, height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
    }
    
    public func configure(with model: SettingsRegisOption) {
        label.text = model.title
        iconImageView.image = model.icon
        codeLabel.text = codeSettingLabelText(isCodeActivated: LocalState.isCodeActivated)
        codeLabel.sizeToFit()
        codeLabel.frame = CGRect(x: contentView.frame.size.width - codeLabel.frame.size.width - 14, y: 0, width: codeLabel.frame.size.width, height: contentView.frame.size.height)
        // ("click regis configure")
    }
    
    private func codeSettingLabelText(isCodeActivated: Bool) -> String {
        if isCodeActivated {
            return "등록"
        } else {
            return "미등록"
        }
    }
}

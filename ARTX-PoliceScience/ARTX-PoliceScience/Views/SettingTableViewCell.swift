//
//  SettingTableViewCell.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/5/23.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    static let identifier = "SettingTableViewCell"
    
    
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .colorsBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconImageView)
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
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
    }
    
    public func configure(with model: SettingsOption) {
        label.text = model.title
        iconImageView.image = model.icon
        // ("click static configure")
    }
    
    
}

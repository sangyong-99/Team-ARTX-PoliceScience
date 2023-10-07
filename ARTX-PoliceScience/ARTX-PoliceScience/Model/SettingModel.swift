//
//  SettingModel.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/6/23.
//

import UIKit

struct SettingTableSection {
    let title: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType{
    case staticCell(model: SettingsOption)
    case regisCell(model: SettingsRegisOption)
}

struct SettingsRegisOption {
    let title: String
    let icon: UIImage?
    var regisCodeBool: Bool
    let handler: (UITableView, IndexPath) -> Void
    
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let handler: (UITableView, IndexPath) -> Void
}

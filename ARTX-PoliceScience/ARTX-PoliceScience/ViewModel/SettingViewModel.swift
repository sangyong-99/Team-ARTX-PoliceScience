//
//  SettingViewModel.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/6/23.
//

import UIKit

class SettingViewModel {
    static var models = [SettingTableSection]()
    
    static func configure(){
        // MARK: - InformationViewController 연결
        models.append(SettingTableSection(title: "Information", options: [
            SettingsOption(title: "조현 경찰학이란?", icon: UIImage(systemName: "book.closed")) {
                print("IntroductionViewConroller Connect")
            },
        ]))
        
        
        // MARK: - CodeSetting alert연결
        models.append(SettingTableSection(title: "CodeSetting", options: [
            SettingsOption(title: "인증코드 등록", icon: UIImage(systemName: "barcode.viewfinder"), handler: SettingViewAlert.showCodeSettingAlert),
            
            // MARK: - code reset alert 연결
            SettingsOption(title: "기기 변경", icon: UIImage(systemName: "iphone.and.arrow.forward"), handler: SettingViewAlert.changeDevice),
        ]))
        
        // MARK: - app reset alert 연결
        models.append(SettingTableSection(title: "AppReset", options: [
            SettingsOption(title: "학습 기록 초기화", icon: UIImage(systemName: "arrow.triangle.2.circlepath")) {
                print("AppResetAlert")
            },
        ]))
    }
    
    
}

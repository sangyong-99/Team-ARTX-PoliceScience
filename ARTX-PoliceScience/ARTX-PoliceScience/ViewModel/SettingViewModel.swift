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
            SettingsOption(title: "인증코드 등록", icon: UIImage(systemName: "barcode.viewfinder"), handler: {
                if LocalState.isCodeActivated == true {
                    print("이미 코드가 등록되어 활성화 되어있습니다.")
                    return
                }
                SettingViewAlert.showCodeSettingAlert()
            }),
            
            // MARK: - code reset alert 연결
            SettingsOption(title: "기기 변경", icon: UIImage(systemName: "iphone.and.arrow.forward"), handler: {
                guard let authenticationCode = LocalState.authenticationCode else {
                    print("LocalState.authenticationCode에 코드가 없음 alert 코드 비활성화 실행불가")
                    return
                }
                if (LocalState.isCodeActivated == true) {
                    SettingViewAlert.changeDevice(authenticationCode: authenticationCode)
                } else {
                    print("LocalState.isCodeActivated와 LocalState.authenticationCode의 동기화 error")
                }
                
            }),
        ]))
        
        // MARK: - app reset alert 연결
        models.append(SettingTableSection(title: "AppReset", options: [
            SettingsOption(title: "학습 기록 초기화", icon: UIImage(systemName: "arrow.triangle.2.circlepath"), handler: SettingViewAlert.appResetAlert),
        ]))
    }
    
    
}

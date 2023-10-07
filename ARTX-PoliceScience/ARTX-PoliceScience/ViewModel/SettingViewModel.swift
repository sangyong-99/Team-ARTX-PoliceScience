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
        models.append(SettingTableSection(title: "Information", options: [.staticCell(model: SettingsOption(title: "조현 경찰학이란?", icon: UIImage(systemName: "book.closed")) { tableView, indexPath in
            print("IntroductionViewConroller Connect")
        })]))
        
        
        // MARK: - CodeSetting alert연결
        models.append(SettingTableSection(title: "CodeSetting", options: [
            
            .regisCell(model: SettingsRegisOption(title: "인증코드 등록", icon: UIImage(systemName: "barcode.viewfinder"), regisCodeBool: true, handler: { tableView, indexPath in
                if LocalState.isCodeActivated == true {
                    print("이미 코드가 등록되어 활성화 되어있습니다.")
                    return
                }
                SettingViewAlert.showCodeSettingAlert(tableView: tableView, indexPath: indexPath)
            })),
            
            // MARK: - code reset alert 연결
            .staticCell(model: SettingsOption(title: "기기 변경", icon: UIImage(systemName: "iphone.and.arrow.forward"), handler: { tableView, indexPath in
                guard let authenticationCode = LocalState.authenticationCode else {
                    print("LocalState.authenticationCode에 코드가 없음 alert 코드 비활성화 실행불가")
                    return
                }
                if (LocalState.isCodeActivated == true) {
                    SettingViewAlert.changeDevice(authenticationCode: authenticationCode, tableView: tableView, indexPath: indexPath)
                } else {
                    print("LocalState.isCodeActivated와 LocalState.authenticationCode의 동기화 error")
                }
                
            }))
            
        ]))
        
        // MARK: - app reset alert 연결
        models.append(SettingTableSection(title: "AppReset", options: [.staticCell(model: SettingsOption(title: "학습 기록 초기화", icon: UIImage(systemName: "arrow.triangle.2.circlepath"), handler: { tableView, indexPath in SettingViewAlert.appResetAlert()
        }))
            
        ]))
    }
}

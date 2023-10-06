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
            SettingsOption(title: "인증코드 등록", icon: UIImage(systemName: "barcode.viewfinder")) {
                let codeSettingAlert = UIAlertController(
                    title: "인증 코드를 입력해 주세요",
                    message: "코드를 입력해 잠금을 해제해 주세요.",
                    preferredStyle: .alert
                )
                
                codeSettingAlert.addTextField { codeSettingField in
                    codeSettingField.placeholder = "코드 입력"
                    codeSettingField.returnKeyType = .next
                    codeSettingField.keyboardType = .default
                }
                
                //alert button 이랑 action
                codeSettingAlert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
                codeSettingAlert.addAction(UIAlertAction(title: "입력", style: .default, handler: {_ in
                    // 입력 클릭했을때 실행하는 로직
                    guard let codeSettingField = codeSettingAlert.textFields else {
                        return
                    }
                    let authenticationCode = codeSettingField[0]
                    guard let authenticationCode = authenticationCode.text else {
                        return
                    }
                    //alert창 입력 값
//                    print(authenticationCode)
                    
                    //firestore 연결 코드 성공 여부 bool 값리턴
                    FirebaseManager.setCodeFirestore(code: authenticationCode) { success in
                        print("성공여부 : \(success)")
                    }
                }))
                
                // 현재화면에 띄어주는 로직
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    if let window = scene.windows.first {
                        if let rootViewController = window.rootViewController {
                            rootViewController.present(codeSettingAlert, animated: true, completion: nil)
                        }
                    }
                }
            },
            
            // MARK: - code reset alert 연결
            SettingsOption(title: "기기 변경", icon: UIImage(systemName: "iphone.and.arrow.forward")) {
                print("Reset Alert")
            },
        ]))
        
        // MARK: - app reset alert 연결
        models.append(SettingTableSection(title: "AppReset", options: [
            SettingsOption(title: "학습 기록 초기화", icon: UIImage(systemName: "arrow.triangle.2.circlepath")) {
                print("AppResetAlert")
            },
        ]))
    }
    
    
}

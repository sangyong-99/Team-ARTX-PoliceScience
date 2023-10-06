//
//  SettingViewAlert.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/7/23.
//

import Foundation
import UIKit

class SettingViewAlert {
    static func showCodeSettingAlert() {
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
        codeSettingAlert.addAction(UIAlertAction(title: "취소", style: .default, handler: nil))
        codeSettingAlert.addAction(UIAlertAction(title: "입력", style: .cancel, handler: {_ in
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
                if success {
                    successCodeAlert()
                } else {
                    failCodeAlert()
                }
            }
        }))
        
        // alert 창을 현재화면에 띄어주는 로직
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = scene.windows.first {
                if let rootViewController = window.rootViewController {
                    rootViewController.present(codeSettingAlert, animated: true, completion: nil)
                }
            }
        }
    }
    
    static func successCodeAlert() {
        let codeSettingAlert = UIAlertController(
            title: "코드 인증이 완료되었습니다",
            message: "모든 문제의 잠금이 해제되었습니다.",
            preferredStyle: .alert
        )
        
        //alert button 이랑 action
        codeSettingAlert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        
        // alert 창을 현재화면에 띄어주는 로직
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = scene.windows.first {
                if let rootViewController = window.rootViewController {
                    rootViewController.present(codeSettingAlert, animated: true, completion: nil)
                }
            }
        }
    }
    
    static func failCodeAlert() {
        let codeSettingAlert = UIAlertController(
            title: "잘못된 인증 코드입니다",
            message: "코드를 확인하고 다시 시도해 주세요.",
            preferredStyle: .alert
        )
        
        //alert button 이랑 action
        codeSettingAlert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        
        // alert 창을 현재화면에 띄어주는 로직
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = scene.windows.first {
                if let rootViewController = window.rootViewController {
                    rootViewController.present(codeSettingAlert, animated: true, completion: nil)
                }
            }
        }
    }
}


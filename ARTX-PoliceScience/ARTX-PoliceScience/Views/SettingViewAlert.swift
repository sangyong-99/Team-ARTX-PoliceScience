//
//  SettingViewAlert.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/7/23.
//

import Foundation
import UIKit

class SettingViewAlert {
    static func showCodeSettingAlert(tableView: UITableView, indexPath: IndexPath) {
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
                    
//                        if let cell = tableView.cellForRow(at: indexPath) as? RegisSettingTableViewCell {
//                            cell.rerendering()
//                        }
                    
                    
                    
                    tableView.reloadRows(at: [indexPath], with: .automatic)
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
    
    static func changeDevice(authenticationCode: String, tableView: UITableView, indexPath: IndexPath) {
        let changeDeviceAlert = UIAlertController(
            title: "현재 기기의 인증 코드를\n비활성화 하시겠습니까?",
            message: "학습 기록이 초기화됩니다.\n비활성화 된 코드는 새로운 기기에 다시\n사용할 수 있습니다.",
            preferredStyle: .alert
        )
        
        changeDeviceAlert.addAction(UIAlertAction(title: "비활성화", style: .default, handler: { _ in
            FirebaseManager.changeDeviceFirestore(authenticationCode: authenticationCode) { success in
                print("기기변경 성공여부 : \(success)")
                if success {
                    successChangeDeviceAlert()
                    
                    let currentCellIndexPath = IndexPath(row: 0, section: 1)
                    
                    tableView.reloadRows(at: [currentCellIndexPath], with: .automatic)
                    
                    print("성공")
                } else {
                    failChangeDeviceAlert()
                    print("실패")
                }
            }
        }))
        
        //alert button 이랑 action
        changeDeviceAlert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        // alert 창을 현재화면에 띄어주는 로직
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = scene.windows.first {
                if let rootViewController = window.rootViewController {
                    rootViewController.present(changeDeviceAlert, animated: true, completion: nil)
                }
            }
        }
    }
    
    static func successChangeDeviceAlert() {
        let successChangeDeviceAlert = UIAlertController(
            title: "코드가 비활성화 되었습니다",
            message: "코드를 새로운 기기에 등록 해주세요.",
            preferredStyle: .alert
        )
        
        //alert button 이랑 action
        successChangeDeviceAlert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        
        // alert 창을 현재화면에 띄어주는 로직
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = scene.windows.first {
                if let rootViewController = window.rootViewController {
                    rootViewController.present(successChangeDeviceAlert, animated: true, completion: nil)
                }
            }
        }
    }
    
    static func failChangeDeviceAlert() {
        let failChangeDeviceAlert = UIAlertController(
            title: "기기 변경에 실패하였습니다.",
            message: "",
            preferredStyle: .alert
        )
        
        //alert button 이랑 action
        failChangeDeviceAlert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        
        // alert 창을 현재화면에 띄어주는 로직
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = scene.windows.first {
                if let rootViewController = window.rootViewController {
                    rootViewController.present(failChangeDeviceAlert, animated: true, completion: nil)
                }
            }
        }
    }
    
    static func appResetAlert() {
        let appResetAlert = UIAlertController(
            title: "전체 학습기록을\n초기화 하시겠습니까?",
            message: "이 작업은 되돌릴 수 없습니다.",
            preferredStyle: .alert
        )
        
        //alert button 이랑 action
        appResetAlert.addAction(UIAlertAction(title: "초기화", style: .destructive, handler: { _ in
            appResetFunction() { success in
                print("학습 기록 초기화 성공여부 : \(success)")
                if success {
                    successappResetAlert()
                    print("성공")
                } else {
                    failappResetAlert()
                    print("실패")
                }

            }
        }))
        appResetAlert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        // alert 창을 현재화면에 띄어주는 로직
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = scene.windows.first {
                if let rootViewController = window.rootViewController {
                    rootViewController.present(appResetAlert, animated: true, completion: nil)
                }
            }
        }
    }
    
    static func appResetFunction(completion: @escaping (Bool) -> Void) {
        print("app reset 학습 기록 초기화 하는 함수 들어가야 되는 곳")
        completion(true)
    }
    
    static func successappResetAlert() {
        let successappResetAlert = UIAlertController(
            title: "학습 기록 초기화가\n완료되었습니다",
            message: "",
            preferredStyle: .alert
        )
        
        //alert button 이랑 action
        successappResetAlert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        
        // alert 창을 현재화면에 띄어주는 로직
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = scene.windows.first {
                if let rootViewController = window.rootViewController {
                    rootViewController.present(successappResetAlert, animated: true, completion: nil)
                }
            }
        }
    }
    
    static func failappResetAlert() {
        let successappResetAlert = UIAlertController(
            title: "학습 기록 초기화가\n실패되었습니다",
            message: "",
            preferredStyle: .alert
        )
        
        //alert button 이랑 action
        successappResetAlert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        
        // alert 창을 현재화면에 띄어주는 로직
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = scene.windows.first {
                if let rootViewController = window.rootViewController {
                    rootViewController.present(successappResetAlert, animated: true, completion: nil)
                }
            }
        }
    }
}


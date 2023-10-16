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
        let text = SettingShowCodeAlertText.self
        
        let codeSettingAlert = UIAlertController(
            title: text.title,
            message: text.message,
            preferredStyle: .alert
        )
        
        codeSettingAlert.addTextField { codeSettingField in
            codeSettingField.placeholder = text.placeholder
            codeSettingField.returnKeyType = .next
            codeSettingField.keyboardType = .default
        }
        
        codeSettingAlert.addAction(UIAlertAction(title: text.cancelButton, style: .cancel, handler: nil))
        codeSettingAlert.addAction(UIAlertAction(title: text.button, style: .default, handler: {_ in
            // 입력 클릭했을때 실행하는 로직
            guard let codeSettingField = codeSettingAlert.textFields else {
                return
            }
            let authenticationCode = codeSettingField[0]
            guard let authenticationCode = authenticationCode.text else {
                return
            }
            
            //firestore 연결 코드 성공 여부 bool 값리턴
            FirebaseManager.setCodeFirestore(code: authenticationCode) { success in
                // ("성공여부 : \(success)")
                if success {
                    successCodeAlert()
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                } else {
                    failCodeAlert()
                }
            }
        }))
        
        codeSettingAlert.show()
    }
    
    static func successCodeAlert() {
        let text = SuccessCodeAlertText.self
        
        let codeSettingAlert = UIAlertController(
            title: text.title,
            message: text.message,
            preferredStyle: .alert
        )
        
        codeSettingAlert.addAction(UIAlertAction(title: text.button, style: .cancel, handler: nil))
        codeSettingAlert.show()
    }
    
    static func failCodeAlert() {
        let text = FailCodeAlertText.self
        
        let codeSettingAlert = UIAlertController(
            title: text.title,
            message: text.message,
            preferredStyle: .alert
        )
        
        codeSettingAlert.addAction(UIAlertAction(title: text.button, style: .cancel, handler: nil))
        codeSettingAlert.show()
    }
    
    static func changeDevice(authenticationCode: String, tableView: UITableView, indexPath: IndexPath) {
        let text = ChangeDeviceText.self
        
        let changeDeviceAlert = UIAlertController(
            title: text.title,
            message: text.message,
            preferredStyle: .alert
        )
        
        changeDeviceAlert.addAction(UIAlertAction(title: text.button, style: .default, handler: { _ in
            FirebaseManager.changeDeviceFirestore(authenticationCode: authenticationCode) { success in
                // ("기기변경 성공여부 : \(success)")
                if success {
                    successChangeDeviceAlert()
                    
                    let currentCellIndexPath = IndexPath(row: 0, section: 1)
                    
                    tableView.reloadRows(at: [currentCellIndexPath], with: .automatic)
                    
                    // ("성공")
                } else {
                    failChangeDeviceAlert()
                    // ("실패")
                }
            }
        }))
        
        changeDeviceAlert.addAction(UIAlertAction(title: text.cancelButton, style: .cancel, handler: nil))
        changeDeviceAlert.show()
    }
    
    static func successChangeDeviceAlert() {
        let text = SuccessChangeDeviceText.self
        
        let successChangeDeviceAlert = UIAlertController(
            title: text.title,
            message: text.message,
            preferredStyle: .alert
        )
        
        successChangeDeviceAlert.addAction(UIAlertAction(title: text.button, style: .cancel, handler: nil))
        successChangeDeviceAlert.show()
    }
    
    static func failChangeDeviceAlert() {
        let text = FailChangeDeviceText.self
        
        let failChangeDeviceAlert = UIAlertController(
            title: text.title,
            message: text.message,
            preferredStyle: .alert
        )
        
        failChangeDeviceAlert.addAction(UIAlertAction(title: text.button, style: .cancel, handler: nil))
        failChangeDeviceAlert.show()
    }
    
    static func appResetAlert() {
        let text = AppResetText.self
        
        let appResetAlert = UIAlertController(
            title: text.title,
            message: text.message,
            preferredStyle: .alert
        )
        
        appResetAlert.addAction(UIAlertAction(title: text.button, style: .destructive, handler: { _ in
            appResetFunction() { success in
                // ("학습 기록 초기화 성공여부 : \(success)")
                if success {
                    successappResetAlert()
                    // ("성공")
                } else {
                    failappResetAlert()
                    // ("실패")
                }

            }
        }))
        
        appResetAlert.addAction(UIAlertAction(title: text.cancelButton, style: .cancel, handler: nil))
        appResetAlert.show()
    }
    
    static func appResetFunction(completion: @escaping (Bool) -> Void) {
        // ("app reset 학습 기록 초기화 하는 함수 들어가야 되는 곳")
        completion(true)
    }
    
    static func successappResetAlert() {
        let text = SuccessAppResetText.self
        
        let successAppResetAlert = UIAlertController(
            title: text.title,
            message: text.message,
            preferredStyle: .alert
        )
        
        successAppResetAlert.addAction(UIAlertAction(title: text.button, style: .cancel, handler: nil))
        successAppResetAlert.show()
    }
    
    static func failappResetAlert() {
        let text = FailAppResetText.self
        
        let successAppResetAlert = UIAlertController(
            title: text.title,
            message: text.message,
            preferredStyle: .alert
        )
        
        successAppResetAlert.addAction(UIAlertAction(title: text.button, style: .cancel, handler: nil))
        successAppResetAlert.show()
    }
    
    static func alreadyRegisterCodeAlert() {
        let text = AlreadyRegisterCodeText.self
        
        let alreadyRegisterCodeAlert = UIAlertController(
            title: text.title,
            message: text.message,
            preferredStyle: .alert
        )
        
        alreadyRegisterCodeAlert.addAction(UIAlertAction(title: text.button, style: .default))
        alreadyRegisterCodeAlert.show()
    }
    
    static func noRegisterCodeAlert() {
        let text = NoRegisterCodeText.self
        
        let noRegisterCodeAlert = UIAlertController(
            title: text.title,
            message: text.message,
            preferredStyle: .alert
        )
        
        noRegisterCodeAlert.addAction(UIAlertAction(title: text.button, style: .default))
        noRegisterCodeAlert.show()
    }
}


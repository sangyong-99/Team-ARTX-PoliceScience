//
//  HomeViewAlert.swift
//  ARTX-PoliceScience
//
//  Created by Jae Ho Yoon on 10/14/23.
//

import UIKit

class HomeViewAlert {
    static func continueAlert() {
        let text = ContinueAlertText.self
        
        let alert = UIAlertController(title: text.title, message: text.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: text.restartButton, style: .default) { _ in
            //TODO: 첫번째 문제부터 시작
        })
        
        let boldButton = UIAlertAction(title: text.continueButton, style: .default) { _ in
            //TODO: 풀었던 문제부터 시작
        }
        alert.addAction(boldButton)
        alert.preferredAction = boldButton
        
        alert.show()
    }
    
    static func restartAlert() {
        let text = RestartAlertText.self
        
        let alert = UIAlertController(title: text.title, message: text.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: text.button, style: .default) { _ in
            //TODO: 첫번째 문제부터 시작
        })
        alert.addAction(UIAlertAction(title: text.cancelButton, style: .cancel))
        
        alert.show()
    }
    
    static func needActivateAlert() {
        let text = NeedActivationAlertText.self
        
        let alert = UIAlertController(title: text.title, message: text.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: text.button, style: .default, handler: { _ in
            //TODO: 인증 코드 입력
        }))
        alert.addAction(UIAlertAction(title: text.cancelButton, style: .cancel))
        
        alert.show()
    }
}


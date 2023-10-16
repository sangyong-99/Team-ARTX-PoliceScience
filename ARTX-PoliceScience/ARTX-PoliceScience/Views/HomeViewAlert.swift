//
//  HomeViewAlert.swift
//  ARTX-PoliceScience
//
//  Created by Jae Ho Yoon on 10/14/23.
//

import UIKit

class HomeViewAlert {
    
    static func continueAlert(from viewController: UIViewController, indexPath: IndexPath, currentQuizNumber: Int) {
        let text = ContinueAlertText.self
        
        let alert = UIAlertController(title: text.title, message: text.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: text.restartButton, style: .default) { _ in
            let targetViewController = QuizViewController(partNumber: indexPath.section, partTitle: globalQuestion.quiz[indexPath.section].part_name, chapter: globalQuestion.quiz[indexPath.section].chapters[indexPath.row], currentQuizNumber: 0)
            
            viewController.navigationController?.pushViewController(targetViewController, animated: true)
            viewController.navigationController?.isNavigationBarHidden = false
        })
        
        let boldButton = UIAlertAction(title: text.continueButton, style: .default) { _ in
            let targetViewController = QuizViewController(partNumber: indexPath.section, partTitle: globalQuestion.quiz[indexPath.section].part_name, chapter: globalQuestion.quiz[indexPath.section].chapters[indexPath.row], currentQuizNumber: currentQuizNumber)
            
            viewController.navigationController?.pushViewController(targetViewController, animated: true)
            viewController.navigationController?.isNavigationBarHidden = false
        }
        alert.addAction(boldButton)
        alert.preferredAction = boldButton
        
        alert.show()
    }
    
    static func restartAlert(from viewController: UIViewController, indexPath: IndexPath) {
        let text = RestartAlertText.self
        
        let alert = UIAlertController(title: text.title, message: text.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: text.button, style: .default) { _ in
            let targetViewController = QuizViewController(partNumber: indexPath.section, partTitle: globalQuestion.quiz[indexPath.section].part_name, chapter: globalQuestion.quiz[indexPath.section].chapters[indexPath.row], currentQuizNumber: 0)
            
            viewController.navigationController?.pushViewController(targetViewController, animated: true)
            viewController.navigationController?.isNavigationBarHidden = false
        })
        
        alert.addAction(UIAlertAction(title: text.cancelButton, style: .cancel))
        
        alert.show()
    }
    
    static func needActivateAlert(from viewController: UIViewController) {
        let text = NeedActivationAlertText.self
        
        let alert = UIAlertController(title: text.title, message: text.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: text.button, style: .default, handler: { _ in
            viewController.navigationController?.pushViewController(SettingViewModel.settingViewController, animated: true)
        }))
        alert.addAction(UIAlertAction(title: text.cancelButton, style: .cancel))
        
        alert.show()
    }
}

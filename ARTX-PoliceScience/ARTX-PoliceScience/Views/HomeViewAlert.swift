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
        let homeViewAlert = HomeViewAlert()
        
        let alert = UIAlertController(title: text.title, message: text.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: text.restartButton, style: .default) { _ in
            let targetViewController = QuizViewController(indexPath: indexPath, showBookmarkedOnly: false, questions: globalQuestion.quiz[indexPath[0]].chapters[indexPath[1]].questions)
            
            let partChapterString = PartChapter.partIntToString(partIndex: indexPath.section, chapterIndex: indexPath.row)
            UserDefaults.standard.set(0, forKey: partChapterString)
            targetViewController.delegate = viewController.self as? any QuizViewConrollerDelegate
            
            let accuracyFormat = PartChapter.homeGenerateAccuracyFormat(partIndex: indexPath.section + 1, chapterIndex: indexPath.row + 1)
            PartChapter.removeValueForExistingKey(key: accuracyFormat)
            
            viewController.navigationController?.pushViewController(targetViewController, animated: true)
            viewController.navigationController?.isNavigationBarHidden = false
        })
        
        let boldButton = UIAlertAction(title: text.continueButton, style: .default) { _ in
            let targetViewController = QuizViewController(indexPath: indexPath, showBookmarkedOnly: false, questions: globalQuestion.quiz[indexPath[0]].chapters[indexPath[1]].questions)
            targetViewController.delegate = viewController.self as? any QuizViewConrollerDelegate
            
            viewController.navigationController?.pushViewController(targetViewController, animated: true)
            viewController.navigationController?.isNavigationBarHidden = false
        }
        alert.addAction(boldButton)
        alert.preferredAction = boldButton
        
        alert.show()
    }
    
    static func restartAlert(from viewController: UIViewController, indexPath: IndexPath) {
        let text = RestartAlertText.self
        let homeViewAlert = HomeViewAlert()
        
        let alert = UIAlertController(title: text.title, message: text.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: text.button, style: .default) { _ in
            let targetViewController = QuizViewController(indexPath: indexPath, showBookmarkedOnly: false, questions: globalQuestion.quiz[indexPath[0]].chapters[indexPath[1]].questions)
            
            let partChapterString = PartChapter.partIntToString(partIndex: indexPath.section, chapterIndex: indexPath.row)
            UserDefaults.standard.set(0, forKey: partChapterString)
            targetViewController.delegate = viewController.self as? any QuizViewConrollerDelegate
            
            let accuracyFormat = PartChapter.homeGenerateAccuracyFormat(partIndex: indexPath.section + 1, chapterIndex: indexPath.row + 1)
            PartChapter.removeValueForExistingKey(key: accuracyFormat)
            
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

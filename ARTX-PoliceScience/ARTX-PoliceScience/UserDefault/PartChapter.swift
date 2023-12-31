//
//  PartChapter.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/16/23.
//

import UIKit

class PartChapter {
    static func resetPartChapter() {
        for (partIndex, part) in globalQuestion.quiz.enumerated() {
            for (chapterIndex, _) in part.chapters.enumerated() {
                
                let partIndexString = partIntToString(partIndex: partIndex, chapterIndex: chapterIndex)
                UserDefaults.standard.set(0, forKey: partIndexString)
            }
        }
    }
    
        
    static func totalCurrentSolveQuestionNum() -> Int {
        var totalNumber = 0
        for (partIndex, part) in globalQuestion.quiz.enumerated() {
            for (chapterIndex, _) in part.chapters.enumerated() {
                
                let partIndexString = partIntToString(partIndex: partIndex, chapterIndex: chapterIndex)
                totalNumber += UserDefaults.standard.integer(forKey: partIndexString)
                
                
            }
        }
        return totalNumber
    }
    
    static func partIntToString(partIndex: Int, chapterIndex: Int) -> String{
        var partIndexString = String(format: "%02d", partIndex + 1)
        partIndexString += String(format: "%02d", chapterIndex + 1)
        
        return partIndexString
    }
    
    
    static func homeGenerateAccuracyFormat(partIndex: Int, chapterIndex: Int) -> String {
        let accuracyRateId =  String("!") + String(format: "%02d", partIndex) + String(format: "%02d", chapterIndex)
        return accuracyRateId
    }
    
    static func removeValueForExistingKey(key: String) {
        if let index = LocalState.accuracyRateList.firstIndex(where: { $0.keys.contains(key) }) {
            LocalState.accuracyRateList.remove(at: index)
        }
        
    }
    
    static func returnValueForExistingKey(key: String) -> Int {
        guard let accuracy = LocalState.accuracyRateList.lazy.compactMap({ $0[key] }).first else {
               return 0
           }
           return accuracy
    }

}

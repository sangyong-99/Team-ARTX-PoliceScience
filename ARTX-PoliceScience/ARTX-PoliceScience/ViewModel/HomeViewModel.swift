//
//  HomeViewModel.swift
//  ARTX-PoliceScience
//
//  Created by Jae Ho Yoon on 10/9/23.
//

import UIKit

class HomeViewModel {
    
    static var sections = [HomeTableSection]()
    static var cells = [HomeTableCell]()
    static var quizes = [Quiz]()
    
    static func configure() {
        sections.append(HomeTableSection(partNumber: "PART 1", partTitle: "경찰학의 기초이론", chapters:
                                            [HomeTableCell(completionIcon: .iconCompletionTrue, chapterNumber: "CHAPTER 01", chapterTitle: "경찰 개념의 연혁", quizCount: "30 / 30"),
 HomeTableCell(completionIcon: .iconCompletionFalse, chapterNumber: "CHAPTER 02", chapterTitle: "경찰 개념의 연혁", quizCount: "5 / 30"),
 HomeTableCell(completionIcon: .iconCompletionFalse, chapterNumber: "CHAPTER 03", chapterTitle: "경찰과 윤리", quizCount: "0 / 30")
        ]))
        
        sections.append(HomeTableSection(partNumber: "PART 2", partTitle: "한국경찰의 역사와 비교", chapters:
[HomeTableCell(completionIcon: .iconCompletionFalse, chapterNumber: "CHAPTER 01", chapterTitle: "한국경찰의 역사", quizCount: "0 / 30"),
 HomeTableCell(completionIcon: .iconCompletionFalse, chapterNumber: "CHAPTER 02", chapterTitle: "비교경찰", quizCount: "0 / 30")
        ]))
        
        sections.append(HomeTableSection(partNumber: "PART 3", partTitle: "경찰행정학", chapters:
[HomeTableCell(completionIcon: .iconCompletionFalse, chapterNumber: "CHAPTER 01", chapterTitle: "경찰관리", quizCount: "0 / 30"),
 HomeTableCell(completionIcon: .iconCompletionFalse, chapterNumber: "CHAPTER 02", chapterTitle: "경찰홍보 및 통제", quizCount: "0 / 30")
        ]))
    }
}

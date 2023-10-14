//
//  BookmarkViewModel.swift
//  ARTX-PoliceScience
//
//  Created by apple on 10/12/23.
//

import Foundation

class BookmarkViewModel {
    private let Quizs: [Quiz] = [
            Quiz(part: 1, partName: "경찰학", chapters: [
                Chapter(chapter: 1, chapterName: "경찰 연혁", questions: [
                    Question(question: "문제 1", answer: "O", explanation: "해설 1"),
                    Question(question: "문제 2", answer: "X", explanation: "해설 2"),
                    Question(question: "문제 3", answer: "O", explanation: "해설 3")
                ])
            ])
        ]
    private var currentPart: Int = 0
    private var currentChapter: Int = 0

    func ChangeCurrentPart(to number: Int) {
        self.currentPart = number
    }
    
    func ChangeCurrentChapter(to number: Int) {
        self.currentChapter = number
    }
    
    func partNumber() -> Int {
        return Quizs[self.currentPart].part
    }
    
    func partTitle() -> String {
        return Quizs[self.currentPart].partName
    }
    
    func chapterNumber() -> Int {
        return Quizs[self.currentPart].chapters[self.currentChapter].chapter
    }
    
    func chapterTitle() -> String {
        return Quizs[self.currentPart].chapters[self.currentChapter].chapterName
    }
    
    func partCount() -> Int {
        return Quizs.count
    }
    
    func chapterCount() -> Int {
        return Quizs[self.currentPart].chapters.count
    }
    
    func bookmarkQuizeCount() -> Int {
        return Quizs[self.currentPart].chapters[self.currentChapter].questions.count
    }
}

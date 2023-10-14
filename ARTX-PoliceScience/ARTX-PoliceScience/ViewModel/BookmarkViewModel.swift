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
                Chapter(chapter: 1, chapterName: "경찰이란", questions: [
                    Question(question: "문제 1", answer: "O", explanation: "해설 1"),
                    Question(question: "문제 2", answer: "X", explanation: "해설 2"),
                    Question(question: "문제 3", answer: "O", explanation: "해설 3")
                ]),
                Chapter(chapter: 2, chapterName: "경찰 연혁", questions: [
                    Question(question: "문제 1", answer: "O", explanation: "해설 1")
                ])
            ]),
            Quiz(part: 2, partName: "경찰행정", chapters: [
                Chapter(chapter: 1, chapterName: "경찰행정법", questions: [
                    Question(question: "문제 1", answer: "O", explanation: "해설 1"),
                    Question(question: "문제 2", answer: "X", explanation: "해설 2"),
                    Question(question: "문제 3", answer: "O", explanation: "해설 3"),
                    Question(question: "문제 4", answer: "O", explanation: "해설 4")
                ])
            ]),
            Quiz(part: 3, partName: "경찰메롱", chapters: []),
            Quiz(part: 4, partName: "경찰법률", chapters: [
                 Chapter(chapter: 1, chapterName: "경찰의 미래", questions: [
                     Question(question: "문제 1", answer: "O", explanation: "해설 1"),
                     Question(question: "문제 2", answer: "X", explanation: "해설 2"),
                     Question(question: "문제 3", answer: "O", explanation: "해설 3")
                 ])
             ]),
        ]
    private var currentPart: Int = 0
    private var currentChapter: Int = 0

    func changeCurrentPart(to number: Int) {
        self.currentPart = number
    }
    
    func changeCurrentChapter(to number: Int) {
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

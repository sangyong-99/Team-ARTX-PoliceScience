//
//  BookmarkViewModel.swift
//  ARTX-PoliceScience
//
//  Created by apple on 10/12/23.
//

import Foundation

class BookmarkViewModel {
    private let quizzes: [Quiz]
    
    private var currentPart: Int = 0
    private var currentChapter: Int = 0
    
    init() {
        let bookmarks = ["0101001", "0101002", "0301001"]
        var quizzes: [Quiz] = []
        
        for quiz in globalQuestion.quiz {
            let quizNumber = quiz.part
            var newQuiz = quiz
            
            for chapter in quiz.chapters {
                let chapterNumber = chapter.chapter
                var newChapter = chapter
                
                newChapter.questions = []
                for index in chapter.questions.indices {
                    let quizId = String(format: "%02d", quizNumber) + String(format: "%02d", chapterNumber) + String(format: "%03d", index)
                    
                    print(quizId)
                    print(bookmarks.contains(quizId))
                    if bookmarks.contains(quizId) {
                        newChapter.questions.append(chapter.questions[index])
                    }
                }
                print(newChapter.questions)
                newQuiz.chapters.append(newChapter)
            }
            quizzes.append(newQuiz)
        }
        
        self.quizzes = quizzes
    }

    func changeCurrentPart(to number: Int) {
        self.currentPart = number
    }
    
    func changeCurrentChapter(to number: Int) {
        self.currentChapter = number
    }
    
    func partNumber() -> Int {
        return quizzes[self.currentPart].part
    }
    
    func partTitle() -> String {
        return quizzes[self.currentPart].part_name
    }
    
    func chapterNumber() -> Int {
        return quizzes[self.currentPart].chapters[self.currentChapter].chapter
    }
    
    func chapterTitle() -> String {
        return quizzes[self.currentPart].chapters[self.currentChapter].chapter_name
    }
    
    func chapter() -> Chapter {
        return quizzes[self.currentPart].chapters[self.currentChapter]
    }
    
    func partCount() -> Int {
        return quizzes.count
    }
    
    func chapterCount() -> Int {
        return quizzes[self.currentPart].chapters.count
    }
    
    func bookmarkQuizeCount() -> Int {
        return quizzes[self.currentPart].chapters[self.currentChapter].questions.count
    }
}

//
//  QuizLoadViewModel.swift
//  ARTX-PoliceScience
//
//  Created by yusang on 10/14/23.
//

import Foundation

class QuizViewModel {
    
    private let chapter: Chapter
    
    init(chapter: Chapter) {
        self.chapter = chapter
    }
    
    func chapterNumber(to index: Int) -> Int {
        return self.chapter.chapter
    }
    func chapterTitle(to index: Int) -> String {
        return self.chapter.chapter_name
    }
//    나중에 json파일 수정하면 고칠 예정
//    func questionNumber(to index: Int) -> Int {
//        return self.chapter.questions.indices
//        return self.chapter.questions.
//    }
    
    func question(to index: Int) -> String {
        return self.chapter.questions[index].question
    }
    
    func answer(to index: Int) -> Bool {
        return self.chapter.questions[index].answer
    }
    
    func explanation(to index: Int) -> String {
        return self.chapter.questions[index].explanation
    }
    
}

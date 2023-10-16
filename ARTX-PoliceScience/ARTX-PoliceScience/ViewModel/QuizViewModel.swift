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
    
    func chapterTitle(to index: Int) -> String {
        return self.chapter.chapter_name
    }
    
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

//
//  QuizModel.swift
//  ARTX-PoliceScience
//
//  Created by Jae Ho Yoon on 10/10/23.
//

import UIKit

struct Quiz {
    let part: Int
    let partName: String
    let chapters: [Chapter]
}

struct Chapter {
    let chapter: Int
    let chapterName: String
    let questions: [Question]
}

struct Question {
    let question: String
    let answer: String
    let explanation: String
}
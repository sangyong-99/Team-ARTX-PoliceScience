//
//  QuestionModel.swift
//  ARTX-PoliceScience
//


import UIKit

var globalQuestion: QuestionModel = LoadQuestionModel.loadQuestionModel()
var totalQuestionNumber = 0


struct QuestionModel: Codable {
    let quiz: [Quiz]
}

struct Quiz: Codable {
    let part: Int
    let part_name: String
    var chapters: [Chapter]
}

struct Chapter: Codable {
    let chapter: Int
    let chapter_name: String
    var questions: [Question]
}

struct Question : Codable{
    let question: String
    let answer: Bool
    var explanation: String
    let index: Int
}

class LoadQuestionModel {
    static func loadQuestionModel() -> QuestionModel {
        if let path = Bundle.main.path(forResource: "example", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                
                let decoder = JSONDecoder()
                let questionModel = try decoder.decode(QuestionModel.self, from: data)
                
                return questionModel
            } catch {
                print("JSON 디코딩 중 에러 발생: \(error)")
            }
        } else {
            print("JSON 파일을 찾을 수 없습니다.")
        }
        return QuestionModel(quiz: [Quiz(part: 0, part_name: "0", chapters: [Chapter(chapter: 0, chapter_name: "0", questions: [Question(question: "0", answer: false, explanation: "0", index: 0)])])])
    }
}

class totalQuestionCountModel {
    static func totalQuestionCount() {
        for (_, part) in globalQuestion.quiz.enumerated() {
            for (_, chapter) in part.chapters.enumerated() {
                totalQuestionNumber += chapter.questions.count
            }
        }
    }
}

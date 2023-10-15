//
//  File.swift
//  ARTX-PoliceScience
//
//  Created by Jae Ho Yoon on 10/14/23.
//

import Foundation

struct ContinueAlertText {
    static let title = "진행 중인 학습 기록이 있습니다"
    static let message = "계속 이어서 학습하시겠습니까?"
    static let restartButton = "처음부터"
    static let continueButton = "이어서"
}

struct RestartAlertText {
    static let title = "이미 완료한 학습입니다"
    static let message = "처음부터 다시 학습하시겠습니까?"
    static let button = "처음부터"
    static let cancelButton = "취소"
}

struct NeedActivationAlertText {
    static let title = "코드 인증이 필요합니다"
    static let message = "코드 인증이 필요한 문제입니다.\n코드를 입력하시겠습니까?"
    static let button = "코드 입력"
    static let cancelButton = "취소"
}

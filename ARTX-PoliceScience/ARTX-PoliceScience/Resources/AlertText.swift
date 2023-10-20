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

struct SettingShowCodeAlertText {
    static let title = "인증 코드를 입력해 주세요"
    static let message = "코드를 입력해 잠금을 해제해 주세요."
    static let placeholder = "코드 입력"
    static let button = "입력"
    static let cancelButton = "취소"
}

struct SuccessCodeAlertText {
    static let title = "코드 인증이 완료되었습니다"
    static let message = "모든 문제의 잠금이 해제되었습니다."
    static let button = "확인"
}

struct FailCodeAlertText {
    static let title = "잘못된 인증 코드입니다"
    static let message = "코드를 확인하고 다시 시도해 주세요."
    static let button = "확인"
}

struct ChangeDeviceText {
    static let title = "현재 기기의 인증 코드를\n비활성화 하시겠습니까?"
    static let message = "학습 기록이 초기화됩니다.\n비활성화 된 코드는 새로운 기기에 다시\n사용할 수 있습니다."
    static let button = "비활성화"
    static let cancelButton = "취소"
}

struct SuccessChangeDeviceText {
    static let title = "코드가 비활성화 되었습니다"
    static let message = "코드를 새로운 기기에 등록 해주세요."
    static let button = "확인"
}

struct FailChangeDeviceText {
    static let title = "기기 변경에 실패하였습니다."
    static let message = ""
    static let button = "확인"
}

struct AppResetText {
    static let title = "전체 학습기록을\n초기화 하시겠습니까?"
    static let message = "이 작업은 되돌릴 수 없습니다."
    static let button = "초기화"
    static let cancelButton = "취소"
}

struct SuccessAppResetText {
    static let title = "학습 기록 초기화가\n완료되었습니다"
    static let message = ""
    static let button = "확인"
}

struct FailAppResetText {
    static let title = "학습 기록 초기화가\n실패되었습니다"
    static let message = ""
    static let button = "확인"
}

struct AlreadyRegisterCodeText {
    static let title = "이미 코드가 등록되어 있습니다"
    static let message = "기기 변경에서 코드를 해제한 뒤\n다시 시도해 주세요."
    static let button = "확인"
}

struct NoRegisterCodeText {
    static let title = "코드 비활성화에 실패했습니다"
    static let message = "인증 코드가 등록되어 있지 않습니다."
    static let button = "확인"
}

struct QuizBackAlertText {
    static let title = "아직 학습이 남아있습니다"
    static let message = "현재 진행 상태를 저장하고 리스트 화면으로 돌아가시겠습니까?"
    static let button = "돌아가기"
    static let cancelButton = "취소"
}

struct PurchaseAlertText {
    static let title = "책 구매 페이지로 이동합니다"
    static let message = "웹 페이지가 실행됩니다."
    static let button = "이동하기"
    static let cancelButton = "취소"
}

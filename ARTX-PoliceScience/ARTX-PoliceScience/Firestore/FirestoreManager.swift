//
//  FirestoreManager.swift
//  ARTX-PoliceScience
//
//  Created by 신상용 on 10/7/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseManager {
    
    static let db = Firestore.firestore()
    
    static func setCodeFirestore(code authenticationCode: String, completion: @escaping (Bool) -> Void) {
        // Firestore 데이터베이스 참조
        if authenticationCode == "" {
            print("코드 빈칸 입력하지 않았습니다.")
            completion(false)
            return
        }
        
//        let db = Firestore.firestore()
        let documentReference = db.collection("code").document(authenticationCode)
        
        documentReference.getDocument { (document, error) in
            if let document = document, document.exists {
                print("해당 코드 문서가 존재합니다. count 값을 1로 변환합니다.")
                
                guard let data = document.data() else {
                    completion(false)
                    return
                }
                
                if let countdata = data["count"] {
                    if (countdata as! Int != 0) {
                        print("코드 입력 실패 이미 사용한 코드 입니다.")
                        completion(false)
                        return
                    }
                }
                
                documentReference.updateData(["count": 1]) { error in
                    if let error = error {
                        print("업데이트 중 오류 발생: \(error)")
                        completion(false)
                    } else {
                        print("code 입력 성공 업데이트 완료")
                        LocalState.authenticationCode = authenticationCode
                        LocalState.isCodeActivated = true
                        completion(true)
                    }
                }
            } else {
                print("해당 코드 문서가 존재하지 않습니다.")
                completion(false)
            }
        }
    }
    static func changeDeviceFirestore(authenticationCode: String, completion: @escaping (Bool) -> Void) {
        if authenticationCode == "" {
            print("코드 빈칸 입력하지 않았습니다.")
            completion(false)
            return
        }
        
        let documentReference = db.collection("code").document(authenticationCode)
        
        documentReference.getDocument { (document, error) in
            if let document = document, document.exists {
                print("해당 코드 문서가 존재합니다. count 값을 0으로 변환합니다.")
                
                guard let data = document.data() else {
                    completion(false)
                    return
                }
                
                if let countdata = data["count"] {
                    if (countdata as! Int != 1) {
                        print("기기변경 실패 사용중인 코드가 아닙니다.")
                        completion(false)
                        return
                    }
                }
                
                documentReference.updateData(["count": 0]) { error in
                    if let error = error {
                        print("업데이트 중 오류 발생: \(error)")
                        completion(false)
                    } else {
                        print("기기초기화 성공 업데이트 완료")
                        LocalState.authenticationCode = nil
                        LocalState.isCodeActivated = false
                        completion(true)
                    }
                }
            } else {
                print("해당 코드 문서가 존재하지 않습니다.")
                completion(false)
            }
        }
        
    }
}

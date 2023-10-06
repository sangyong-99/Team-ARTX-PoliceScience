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
        let db = Firestore.firestore()
        let documentReference = db.collection("code").document(authenticationCode)
        
        documentReference.getDocument { (document, error) in
            if let document = document, document.exists {
                print("해당 코드 문서가 존재합니다. count 값을 변환합니다.")
                
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
}

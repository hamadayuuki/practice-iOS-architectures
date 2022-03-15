//
//  FireAuthModel.swift
//  RxSwift+Firebase
//
//  Created by 濵田　悠樹 on 2022/03/14.
//

import RxSwift
import Firebase
import FirebaseFirestore

class FireAuthModel {
    init() { }
    
    static func createUserToFireAuth(email: String?, password: String?) {
        // nilチェック
        guard let email = email else { return }
        guard let password = password else { return }
        
        // 登録
        Auth.auth().createUser(withEmail: email, password: password) { (auth, err) in
            if let err = err {
                print("登録失敗: ", err)
            }
            
            guard let uid = auth?.user.uid else { return }
            print("登録成功: ", uid)
        }
    }
}

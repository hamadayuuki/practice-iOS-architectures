//
//  FireStoreModel.swift
//  RxSwift+Firebase
//
//  Created by 濵田　悠樹 on 2022/03/14.
//

import Firebase
import FirebaseFirestore
import RxSwift

class FireStoreModel {
    
    public func featchFireStore() -> Observable<Int> {
        return Observable.create { [weak self] observer in   // Observable を作成 (FireStore は用意されていない)
            
            // FireStore からデータの取得
            var database = Firestore.firestore()
            database.collection("count").addSnapshotListener { (snapshots, err) in   // addSnapshotListener: FireSoterからリアルタイムでデータを取得
                if let err = err {
                     print("Error getting documents: \(err)")
                 } else {
                     if let documents = snapshots?.documents {
                         for document in documents {
                             let data = document.data()
                             //アップデートされた際に行いたい処理を書く
                             let num = data["num"] as? Int ?? 0
                             print(num)
                             observer.onNext(num)   // イベントを通知
                         }
                     }
                 }
             }
            
            return Disposables.create()   // 解放
        }// return Observable.create
        
    }
    
}

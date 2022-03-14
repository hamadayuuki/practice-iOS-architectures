//
//  FireStoreViewModel.swift
//  RxSwift+Firebase
//
//  Created by 濵田　悠樹 on 2022/03/14.
//

import Firebase
import FirebaseFirestore
import RxSwift

class FireStoreViewModel {
    private let model = FireStoreModel()
    
    func featchFireStore() -> Observable<Int> {
        return model.featchFireStore()   // ?Int
            .asObservable()   // Observable 通知を送るために
    }
}

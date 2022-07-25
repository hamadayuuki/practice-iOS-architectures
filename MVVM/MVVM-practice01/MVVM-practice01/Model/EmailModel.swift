//
//  EmailModel.swift
//  MVVM-practice01
//
//  Created by 濵田　悠樹 on 2022/07/25.
//

import RxSwift
import RxCocoa

class EmailModel {
    
    /*
    func addQuestionMark(text: String) -> Observable<String> {
        
        return Observable<String>.create { observer in
            observer.onNext(text + "?")
            return Disposables.create { print("Observable: Dispose") }
        }
        
    }
    */
    
    
    func addQuestionMark(text: String) -> String {
        return text + "?"
    }
}

//
//  EmailViewModel.swift
//  MVVM-practice01
//
//  Created by 濵田　悠樹 on 2022/07/25.
//

import UIKit
import RxSwift
import RxCocoa

class EmailViewModel {
    var result: Driver<String>   // String は
    
    // View からの接続
    init(emailTextField: Driver<String>) {
        // Model への接続
        let emailModel = EmailModel()
        
        // Vのイベント(TextFieldの変化) を Mへ渡して Mから結果を受け取る(result)に入る
        result = emailTextField
            .map { text in
                emailModel.addQuestionMark(text: text)
            }
            .asDriver(onErrorJustReturn: "")
        
    }
    
    /*
    var result: Driver<String>
    
    init(emailTextField: Driver<String>) {
        let emailModel = EmailModel()
        
        result = emailTextField
            .map { text in
                emailModel.addQuestionMark(text: text)
            }
            .asDriver(onErrorJustReturn: "")
        
    }
     */
}

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
    var result: Driver<String>
    
    init(emailTextField: Driver<String>) {
        let emailModel = EmailModel()
        
        result = emailTextField
            .map { text in
                emailModel.addQuestionMark(text: text)
            }
            .asDriver(onErrorJustReturn: "")
        
    }
}
